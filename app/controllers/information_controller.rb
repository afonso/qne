class InformationController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_finished_user_profile, except: :update_cities
  autocomplete :school, :name, :full => true
  
  def new
    if current_user.infos_finished?
      redirect_to information_edit_path
    end
    @information = Information.new
    @states = State.all
    @cities = City.where(state_id: State.first.id)
    @schools = School.all
  end
  
  def edit
    @information = Information.find_by(user: current_user.id)
    @states = State.all
    @cities = City.where(state_id: @information.state.id)
    @schools = School.all
  end
  
  def create
    @information = Information.new(information_params)
    @information.user_id = current_user.id
    respond_to do |format|
      if @information.save
        format.html { redirect_to root_path, notice: 'Informações enviadas com sucesso.' }
        format.json { render :show, status: :created, location: @information }
      else
        format.html { render :new }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @information = Information.find_by(user: current_user.id)

    respond_to do |format|
      if @information.update(information_params)
        format.html { redirect_to root_path, notice: 'Informações atualizadas com sucesso.' }
        format.json { render :show, status: :ok, location: @information }
      else
        format.html { render :edit }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_cities
    @cities = City.where(state_id: params[:state_id])
    respond_to do |format|
      format.js
    end
  end

  private
    def information_params
      params.require(:information).permit(:city_id, :state_id, :school_id, :school_name, :expected_finish, :work_at, :occupation)
    end
end
