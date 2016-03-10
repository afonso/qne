class School < ActiveRecord::Base
  belongs_to :city
  belongs_to :state
  mount_uploader :avatar, AvatarUploader
  scope :starts_with, -> (name) { where("name like ?", "%#{name.upcase}%")}
end
