class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, only: [:index]
  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.all
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    @demand = Demand.find(@proposal.demand_id)
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
    @demand = Demand.find(params[:demand_id])
  end

  # GET /proposals/1/edit
  def edit
    @demand = Demand.find(@proposal.demand_id)
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user_id = current_user.id
    @proposal.status = "new"
    respond_to do |format|
      if @proposal.save
        UserNotifier.send_proposal_mail(current_user, @demand).deliver_now
        format.html { redirect_to @proposal, notice: 'Proposta enviada com sucesso.' }
        format.json { render :show, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    @demand = Demand.find(@proposal.demand_id)
    respond_to do |format|
      if @proposal.update(proposal_params)
        if @proposal.status == "approved"
          UserNotifier.send_propo_approved_mail(current_user, @demand).deliver_now
        end
        format.html { redirect_to @proposal, notice: 'Proposta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:user_id, :how_many, :demand_id, :status, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end
end
