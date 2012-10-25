require 'test_helper'

class ReleaseManagersControllerTest < ActionController::TestCase
  setup do
    @release_manager = release_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:release_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create release_manager" do
    assert_difference('ReleaseManager.count') do
      post :create, release_manager: {  }
    end

    assert_redirected_to release_manager_path(assigns(:release_manager))
  end

  test "should show release_manager" do
    get :show, id: @release_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @release_manager
    assert_response :success
  end

  test "should update release_manager" do
    put :update, id: @release_manager, release_manager: {  }
    assert_redirected_to release_manager_path(assigns(:release_manager))
  end

  test "should destroy release_manager" do
    assert_difference('ReleaseManager.count', -1) do
      delete :destroy, id: @release_manager
    end

    assert_redirected_to release_managers_path
  end
end
