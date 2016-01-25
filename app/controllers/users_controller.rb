class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_finished_user_profile
  before_action :ensure_finished_user_infos
  def show
  end
end
