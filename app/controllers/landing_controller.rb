class LandingController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  
  def index
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def choose
    unless current_user
      redirect_to root_path
    end
  end

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
