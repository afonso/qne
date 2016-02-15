class School < ActiveRecord::Base
  belongs_to :city
  belongs_to :state
end
