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
    sch = School.find(school.id)
    a = {}
    if sch.lati.blank? and sch.longi.blank?
      g = Geokit::Geocoders::GoogleGeocoder.geocode(sch.address + ", " + sch.neighborhood + ", " + sch.city.name.titleize + " - " + sch.state.name.titleize)
      sch.update_attributes(:lati => g.lat, :longi => g.lng)
      a["lat"] = g.lat
      a["lng"] = g.lng
    else
      a["lat"] = sch.lati
      a["lng"] = sch.longi
    end
    return a
  end
end
