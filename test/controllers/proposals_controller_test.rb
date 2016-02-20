require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  setup do
    @proposal = proposals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal" do
    assert_difference('Proposal.count') do
      post :create, proposal: { demand_id: @proposal.demand_id, friday: @proposal.friday, monday: @proposal.monday, saturday: @proposal.saturday, status: @proposal.status, sunday: @proposal.sunday, thursday: @proposal.thursday, tuesday: @proposal.tuesday, user_id: @proposal.user_id, wednesday: @proposal.wednesday }
    end

    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should show proposal" do
    get :show, id: @proposal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal
    assert_response :success
  end

  test "should update proposal" do
    patch :update, id: @proposal, proposal: { demand_id: @proposal.demand_id, friday: @proposal.friday, monday: @proposal.monday, saturday: @proposal.saturday, status: @proposal.status, sunday: @proposal.sunday, thursday: @proposal.thursday, tuesday: @proposal.tuesday, user_id: @proposal.user_id, wednesday: @proposal.wednesday }
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should destroy proposal" do
    assert_difference('Proposal.count', -1) do
      delete :destroy, id: @proposal
    end

    assert_redirected_to proposals_path
  end
end
