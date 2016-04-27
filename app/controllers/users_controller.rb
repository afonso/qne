class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_finished_user_profile
  before_action :ensure_finished_user_infos
  
  def show
    @demands = Demand.where(created_by: current_user.id)
    @groups = Group.where(user_id: current_user.id)
    @proposals = Proposal.where(user_id: current_user.id)
    @volunteereds = Demand.where(accepted_by: current_user.id)
    if @demands.size == 0 and @groups.size == 0 and current_user.role == 'student'
      flash[:notice] = 'Pronto! Veja os pedidos de outras pessoas ou crie uma clicando no botão abaixo.'
      redirect_to demands_path
    elsif @proposals.size == 0 and @volunteereds.size == 0 and current_user.role != 'student'
      flash[:notice] = 'Pronto! Escolha um pedido para ajudar'
      redirect_to demands_path
    end
  end
end
