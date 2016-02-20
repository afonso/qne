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
end
