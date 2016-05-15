class SessionsController < Devise::SessionsController
  respond_to :json
  def new
    redirect_to root_path
  end
end