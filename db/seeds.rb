require 'net/http'
require 'net/https' # for ruby 1.8.7
require 'json'

module BRPopulate
  def self.states
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/afonso/br_populate/master/states.json').body
  end

  def self.capital?(city, state)
    city["name"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = State.new(:acronym => state["acronym"], :name => state["name"].parameterize)
      state_obj.save
      
      state["cities"].each do |city|
        c = City.new
        c.name = city.parameterize
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
  def self.schools1
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/afonso/escolas/master/escolas1.json').body
  end
  def self.schools2
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/afonso/escolas/master/escolas2.json').body
  end
  def self.schools3
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/afonso/escolas/master/escolas3.json').body
  end
  def self.populate
    schools.each do |s|
      estado = State.find_by_name(s["estado"].parameterize)
      cidade = City.find_by_name_and_state_id(s["cidade"].parameterize, estado.id)
      if cidade.nil?
        cidade = City.new(:name => s["cidade"].parameterize, :state_id => estado.id, :capital => false)
        cidade.save
      end
      school_obj = School.new(
        :name => s["nome"], 
        :address => s["endereco"] + ", " + s["numero"], 
        :neighborhood => s["bairro"], 
        :state_id => estado.id,
        :city_id => cidade.id,
        :cep => s["cep"]
        )
      school_obj.save
    end
    schools1.each do |s|
      estado = State.find_by_name(s["estado"].parameterize)
      cidade = City.find_by_name_and_state_id(s["cidade"].parameterize, estado.id)
      if cidade.nil?
        cidade = City.new(:name => s["cidade"].parameterize, :state_id => estado.id, :capital => false)
        cidade.save
      end
      school_obj = School.new(
        :name => s["nome"], 
        :address => s["endereco"] + ", " + s["numero"], 
        :neighborhood => s["bairro"], 
        :state_id => estado.id,
        :city_id => cidade.id,
        :cep => s["cep"]
        )
      school_obj.save
    end
    schools2.each do |s|
      estado = State.find_by_name(s["estado"].parameterize)
      cidade = City.find_by_name_and_state_id(s["cidade"].parameterize, estado.id)
      if cidade.nil?
        cidade = City.new(:name => s["cidade"].parameterize, :state_id => estado.id, :capital => false)
        cidade.save
      end
      school_obj = School.new(
        :name => s["nome"], 
        :address => s["endereco"] + ", " + s["numero"], 
        :neighborhood => s["bairro"], 
        :state_id => estado.id,
        :city_id => cidade.id,
        :cep => s["cep"]
        )
      school_obj.save
    end
    schools3.each do |s|
      estado = State.find_by_name(s["estado"].parameterize)
      cidade = City.find_by_name_and_state_id(s["cidade"].parameterize, estado.id)
      if cidade.nil?
        cidade = City.new(:name => s["cidade"].parameterize, :state_id => estado.id, :capital => false)
        cidade.save
      end
      school_obj = School.new(
        :name => s["nome"], 
        :address => s["endereco"] + ", " + s["numero"], 
        :neighborhood => s["bairro"], 
        :state_id => estado.id,
        :city_id => cidade.id,
        :cep => s["cep"]
        )
      school_obj.save
    end
  end
end


if ENV["cidades"]
  BRPopulate.populate
end
if ENV["escolas"]
  SchoolPopulate.populate
end
