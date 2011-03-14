require 'test_helper'

class DegreeDescriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:degree_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create degree_description" do
    assert_difference('DegreeDescription.count') do
      post :create, :degree_description => { }
    end

    assert_redirected_to degree_description_path(assigns(:degree_description))
  end

  test "should show degree_description" do
    get :show, :id => degree_descriptions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => degree_descriptions(:one).to_param
    assert_response :success
  end

  test "should update degree_description" do
    put :update, :id => degree_descriptions(:one).to_param, :degree_description => { }
    assert_redirected_to degree_description_path(assigns(:degree_description))
  end

  test "should destroy degree_description" do
    assert_difference('DegreeDescription.count', -1) do
      delete :destroy, :id => degree_descriptions(:one).to_param
    end

    assert_redirected_to degree_descriptions_path
  end
end
