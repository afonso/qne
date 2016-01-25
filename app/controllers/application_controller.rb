class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def ensure_finished_user_infos
    if current_user
      if current_user.role
        unless current_user.infos_finished?
          flash[:notice] = "Por favor, complete seus dados."
          redirect_to new_information_path
        end
      else
        redirect_to edit_user_registration_path
      end
    else
      redirect_to root_path
    end
  end

  def ensure_finished_user_profile
    if current_user
      unless current_user.profile_finished?
        flash[:notice] = "Por favor, complete seus dados."
        redirect_to edit_user_registration_path
      end
    else
      redirect_to root_path
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
                                                            :email, 
                                                            :password,
                                                            :password_confirmation, 
                                                            :role,
                                                            :remember_me, 
                                                            :avatar, 
                                                            :avatar_cache,
                                                            :remote_avatar_url
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
