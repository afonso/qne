require 'test_helper'

class DemandsControllerTest < ActionController::TestCase
  setup do
    @demand = demands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:demands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create demand" do
    assert_difference('Demand.count') do
      post :create, demand: { accepted_by: @demand.accepted_by, created_by: @demand.created_by, how_many: @demand.how_many, observation: @demand.observation, period: @demand.period, school_id: @demand.school_id, start_at: @demand.start_at, status: @demand.status, title: @demand.title }
    end

    assert_redirected_to demand_path(assigns(:demand))
  end

  test "should show demand" do
    get :show, id: @demand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @demand
    assert_response :success
  end

  test "should update demand" do
    patch :update, id: @demand, demand: { accepted_by: @demand.accepted_by, created_by: @demand.created_by, how_many: @demand.how_many, observation: @demand.observation, period: @demand.period, school_id: @demand.school_id, start_at: @demand.start_at, status: @demand.status, title: @demand.title }
    assert_redirected_to demand_path(assigns(:demand))
  end

  test "should destroy demand" do
    assert_difference('Demand.count', -1) do
      delete :destroy, id: @demand
    end

    assert_redirected_to demands_path
  end
end
