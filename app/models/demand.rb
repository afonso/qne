class Demand < ActiveRecord::Base
  belongs_to :school
  has_many :groups
  has_many :users, through: :groups

  attr_accessor :title_other

  def full_title
    "#{title} - #{I18n.t(period)}"
  end

  def owner
    User.find(created_by)
  end

  def in_group(user_id)
    Group.where(["demand_id = ? and user_id = ?", id, user_id])
  end

  def helped_by(user_id)
    Proposal.where(["demand_id = ? and user_id = ?", id, user_id])
  end

  def geo
    g = Geokit::Geocoders::GoogleGeocoder.geocode(school.address + ", " + school.neighborhood + ", " + school.city.name.titleize + " - " + school.state.name.titleize + ", " + school.cep)
    sch = School.find(school.id)
    sch.update_attributes(:lati => g.lat, :longi => g.lng)
    return g
  end
end
