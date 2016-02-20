class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_finished_user_profile
  before_action :ensure_finished_user_infos
  def show
    @demands = Demand.where(created_by: current_user.id)
    @groups = Group.where(user_id: current_user.id)
    @proposals = Proposal.where(user_id: current_user.id)
  end
end
