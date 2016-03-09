require 'net/http'
require 'net/https' # for ruby 1.8.7
require 'json'

module BRPopulate
  def self.states
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/celsodantas/br_populate/master/states.json').body
  end

  def self.capital?(city, state)
    city["name"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = State.new(:acronym => state["acronym"], :name => state["name"])
      state_obj.save
      
      state["cities"].each do |city|
        c = City.new
        c.name = city
        c.state_id = state_obj.id
        c.capital = capital?(city, state)
        c.save
      end
    end
  end
end

module SchoolPopulate
  def self.schools
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/afonso/escolas/master/escolas.json').body
  end

  def self.populate
    schools.each do |s|
      school_obj = School.new(:name => s["nome"], :address => s["endereco"] + ", " + s["numero"])
      school_obj.save
    end
  end
end

SchoolPopulate.populate
BRPopulate.populate
