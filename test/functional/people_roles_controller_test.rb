require 'test_helper'

class PersonRolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_role" do
    anssert_difference('PersonRole.count') do
      post :create, :person_role => { }
    end

    assert_redirected_to people_roles_path(assigns(:person_role))
  end

  test "should show person_role" do
    get :show, :id => people_roles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => people_roles(:one).to_param
    assert_response :success
  end

  test "should update person_role" do
    put :update, :id => people_roles(:one).to_param, :person_role => { }
    assert_redirected_to people_roles_path(assigns(:person_role))
  end

  test "should destroy person_role" do
    assert_difference('PersonRole.count', -1) do
      delete :destroy, :id => people_roles(:one).to_param
    end

    assert_redirected_to people_roles_path
  end
end
