require 'test_helper'

class UserActionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create action" do
    assert_difference('UserAction.count') do
      post :create, :user_action=>{:name=>"eett"}
    end

    assert_redirected_to user_action_path(assigns(:user_action))
  end

  test "should show action" do
    get :show, :id => user_actions(:firstAction).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_actions(:firstAction).to_param
    assert_response :success
  end

  test "should update action" do
    put :update, :id => user_actions(:firstAction).to_param, :user_action=>{:name=>"eett"}
    assert_redirected_to user_action_path(assigns(:user_action))
  end

  test "should destroy action" do
    assert_difference('UserAction.count', -1) do
      delete :destroy, :id => user_actions(:firstAction).to_param
    end

    assert_redirected_to user_actions_path
  end
end
