class Demand < ActiveRecord::Base
  belongs_to :school
  has_many :groups
  has_many :users, through: :groups

  attr_accessor :title_other
end
