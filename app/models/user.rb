class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_one :information, inverse_of: :user, dependent: :delete

  has_many :groups
  has_many :demands, through: :groups

  mount_uploader :avatar, AvatarUploader

  def is_oauth?
    uid and provider ? true : false
  end

  def profile_finished?
    #require 'pry'; binding.pry
    name and birthday and role ? true : false
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

  def update_with_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update_attributes(params, *options)   
    clean_up_passwords
    result
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.remote_avatar_url = auth.info.image
      end
    end
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
