class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_one :information, inverse_of: :user, dependent: :delete

  mount_uploader :avatar, AvatarUploader

  def profile_finished?
    #require 'pry'; binding.pry
    name and birthday ? true : false
  end

  def infos_finished?
    if information
      if role == "student"
        information.city or information.state or information.school or information.expected_finish ? true : false
      else
        information.city or information.state ? true : false
      end
    end
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.name = auth.info.name
         user.email = auth.info.email
         user.remote_avatar_url = auth.info.image.gsub('http:','https:')
         user.save!
      end
    end
    #require 'pry'; binding.pry
    return_user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        data.merge!(session["devise.facebook_data"]["info"])
        data.merge!(session["devise.facebook_data"]["extra"]["raw_info"])
        user.name = data["name"] if user.name.blank?
        user.email = data["email"] if user.email.blank?
        user.provider = data["provider"] if user.provider.blank?
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end
end
