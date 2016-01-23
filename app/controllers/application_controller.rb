class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_finished_user_profile, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
 
  protected

  def ensure_finished_user_profile
    if current_user
      unless current_user.profile_finished?
        flash[:notice] = "Por favor, complete seus dados."
        redirect_to edit_user_registration_path
      end
    end
  end
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
                                                            :email, 
                                                            :password,
                                                            :password_confirmation, 
                                                            :remember_me, 
                                                            :avatar, 
                                                            :avatar_cache
                                                           )}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
                                                                  :name, 
                                                                  :birthday,
                                                                  :role,
                                                                  :gender,
                                                                  :email, 
                                                                  :password,
                                                                  :password_confirmation, 
                                                                  :current_password, 
                                                                  :avatar, 
                                                                  :avatar_cache
                                                                  )}
  end
end
