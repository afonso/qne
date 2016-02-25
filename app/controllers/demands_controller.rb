class DemandsController < ApplicationController
  before_action :set_demand, only: [:show, :edit, :update, :destroy]

  # GET /demands
  # GET /demands.json
  def index
    if current_user.role == "admin"
      @demands = Demand.all
    else
      @demands = Demand.where("created_by = ? or (status = 'accepted' or status = 'standby')", current_user.id)
    end
  end

  # GET /demands/1
  # GET /demands/1.json
  def show
  end

  # GET /demands/new
  def new
    @demand = Demand.new
    @schools = School.all
    @accepted_demands = Demand.where(status: "accepted")
  end

  # GET /demands/1/edit
  def edit
    @schools = School.all
    @accepted_demands = Demand.where(status: "accepted").where.not(title: @demand.title)
  end

  def add
    @group = Group.new(demand_id: params[:demand_id])
    @group.user_id = current_user.id
    respond_to do |format|
      if @group.save
        format.html { redirect_to success_demands_path, notice: 'Added to Demand was successfully.' }
        format.json { render :show, status: :created, location: @demand }
      else
        format.html { render :new }
        format.json { render json: @demand.errors, status: :unprocessable_entity }
      end
    end
  end

  def quit
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Você saiu do demanda com sucesso' }
      format.json { head :no_content }
    end
  end

  # POST /demands
  # POST /demands.json
  def create
    @demand = Demand.new(demand_params)
    @demand.created_by = current_user.id
    @demand.status = "new"
    @demand.title = demand_params[:title_other] if demand_params[:title].blank?

    respond_to do |format|
      if @demand.save
        @group = Group.new(demand_id: @demand.id)
        @group.user_id = @demand.created_by
        @group.save
        
        format.html { redirect_to success_demands_path, notice: 'Demand was successfully created.' }
        format.json { render :show, status: :created, location: @demand }
      else
        format.html { render :new }
        format.json { render json: @demand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demands/1
  # PATCH/PUT /demands/1.json
  def update
    params[:demand][:title] = demand_params[:title_other] if demand_params[:title].blank?
    respond_to do |format|
      if @demand.update(demand_params)
        format.html { redirect_to @demand, notice: 'Demand was successfully updated.' }
        format.json { render :show, status: :ok, location: @demand }
      else
        format.html { render :edit }
        format.json { render json: @demand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demands/1
  # DELETE /demands/1.json
  def destroy
    @demand.destroy
    respond_to do |format|
      format.html { redirect_to demands_url, notice: 'Demand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def success
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demand
      @demand = Demand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:demand_id, :user_id)
    end
    
    def demand_params
      params.require(:demand).permit(:other_place, :title_other, :title, :observation, :period, :start_at, :status, :accepted_by, :created_by, :school_id)
    end
end
