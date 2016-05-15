class DemandsController < ApplicationController
  before_action :set_demand, only: [:show, :edit, :update, :destroy]

  # GET /demands
  # GET /demands.json
  def index
    if current_user
      if current_user.role == "admin"
        @demands = Demand.all.page params[:page]
        @udemands = Demand.all.uniq
      else
        @demands = Demand.where("created_by = ? or (status = 'accepted' or status = 'standby')", current_user.id).page params[:page]
        @udemands = Demand.where("created_by = ? or (status = 'accepted' or status = 'standby')", current_user.id).uniq
      end
    else
      redirect_to root_path
    end
  end

  # GET /demands/1
  # GET /demands/1.json
  def show
    unless current_user.role == "admin"
      redirect_to root_path
    end
  end

  # GET /demands/new
  def new
    @demand = Demand.new
    @schools = School.all
    @accepted_demands = Demand.where(status: "accepted").select('distinct title')
  end

  def edit
    @schools = School.all
    @accepted_demands = Demand.where(status: "accepted").where.not(title: @demand.title)
  end

  def add
    @demand_from = Demand.find(params[:demand_id])
    if current_user.information.school.id == @demand_from.school.id
      @group = Group.new(demand_id: params[:demand_id])
      @group.user_id = current_user.id
    else
      @demand = @demand_from.dup
      @demand.created_by = current_user.id
      @demand.school_id = current_user.information.school.id
      @demand.status = "new"
      @demand.start_at = ""
      @demand.created_at = Time.now
      if @demand.save
        @group = Group.new(demand_id: @demand.id)
        @group.user_id = current_user.id
      end
    end
    respond_to do |format|
      if @group.save
        UserNotifier.send_add_email(current_user, @demand).deliver_now
        format.html { redirect_to success_demands_path, notice: 'Adicionado com sucesso.' }
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
        UserNotifier.send_created_email(current_user, @demand).deliver_now
        format.html { redirect_to success_demands_path, notice: 'Pedido enviado com sucesso.' }
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
    unless params[:demand][:start_at].blank?
      params[:demand][:status] = "marked"
    end
    params[:demand][:title] = demand_params[:title_other] if demand_params[:title].blank?
    respond_to do |format|
      if @demand.update(demand_params)
        if @demand.status == "accepted" 
          @group = Group.where(demand_id: @demand.id)
          @group.each do |g| 
            user = User.find(g.user_id)
            UserNotifier.send_approved_mail(user, @demand).deliver_now
          end
        end
        if @demand.status == "marked" 
          @group = Group.where(demand_id: @demand.id)
          @group.each do |g| 
            user = User.find(g.user_id)
            UserNotifier.send_marked_mail(user, @demand).deliver_now
          end
        end
        format.html { redirect_to @demand, notice: 'Pedido atualizado com sucesso.' }
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
    @group = Group.where(demand_id: @demand.id).where(user_id: current_user.id).first
    if @group.destroy
      @demand.destroy
    end
    respond_to do |format|
      format.html { redirect_to demands_url, notice: 'Pedido deletado com sucesso.' }
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
