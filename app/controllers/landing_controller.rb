class LandingController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  before_action :authenticate_user!, only: [:choose]
  
  def index
    if current_user
      redirect_to user_path(current_user)
    end
    @schools = Demand.select('DISTINCT school_id, title').where.not(status: "new")
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
