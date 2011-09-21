require 'test_helper'

class ActionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create action" do
    assert_difference('Action.count') do
      post :create, 'Action.new'=>{:name=>"eett"}
    end

    assert_redirected_to action_path(assigns(:action))
  end

  test "should show action" do
    get :show, :id => actions(:firstAction).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => actions(:firstAction).to_param
    assert_response :success
  end

  test "should update action" do
    put :update, :id => actions(:firstAction).to_param, 'Action.new'=>{:name=>"eett"}
    assert_redirected_to action_path(assigns(:action))
  end

  test "should destroy action" do
    assert_difference('Action.count', -1) do
      delete :destroy, :id => actions(:firstAction).to_param
    end

    assert_redirected_to actions_path
  end
end
