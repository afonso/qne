class Information < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  belongs_to :state
  belongs_to :school
end
