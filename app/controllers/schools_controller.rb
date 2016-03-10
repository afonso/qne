class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, except: [:show]

  # GET /schools
  # GET /schools.json
  def index
    @schools = []
    @schools = School.starts_with(params[:starts_with]) if params[:starts_with].present?
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @demands = Demand.where(school_id: @school.id).where.not(status: "new")
  end

  # GET /schools/new
  def new
    @school = School.new
    @states = State.all
    @cities = City.where(state_id: State.first.id)
  end

  # GET /schools/1/edit
  def edit
    @states = State.all
    @cities = City.where(state_id: @school.state.id) rescue City.where(state_id: State.first.id)
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_cities
    @cities = City.where(state_id: params[:state_id])
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :address, :lati, :longi, :state_id, :city_id, :neighborhood, :cep, :avatar)
    end
end
