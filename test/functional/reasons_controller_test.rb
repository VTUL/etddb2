require 'test_helper'

class ReasonsControllerTest < ActionController::TestCase
  setup do
    @reason = reasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reason" do
    assert_difference('Reason.count') do
      post :create, reason: {  }
    end

    assert_redirected_to reason_path(assigns(:reason))
  end

  test "should show reason" do
    get :show, id: @reason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reason
    assert_response :success
  end

  test "should update reason" do
    put :update, id: @reason, reason: {  }
    assert_redirected_to reason_path(assigns(:reason))
  end

  test "should destroy reason" do
    assert_difference('Reason.count', -1) do
      delete :destroy, id: @reason
    end

    assert_redirected_to reasons_path
  end
end
