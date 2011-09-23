require 'test_helper'

class PeopleRolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create people_role" do
    assert_difference('PeopleRole.count') do
      post :create, :people_role => {:person_id=>"1",:role_id=>"1" }
    end

    assert_redirected_to people_roles_path(assigns(:people_role))
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
    put :update, :id => people_roles(:one).to_param, :people_role => { }
    assert_redirected_to people_roles_path(assigns(:people_role))
  end

  test "should destroy person_role" do
    assert_difference('PeopleRole.count', -1) do
      delete :destroy, :id => people_roles(:one).to_param
    end

    assert_redirected_to people_roles_path
  end
end
