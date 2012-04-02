require 'test_helper'

class DegreesControllerTest < ActionController::TestCase
  setup do
    @degree = degrees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:degrees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create degree" do
    assert_difference('Degree.count') do
      post :create, degree: @degree.attributes
    end

    assert_redirected_to degree_path(assigns(:degree))
  end

  test "should not create degree" do
    assert_no_difference("Degree.count") do
      post :create, degree: {}
    end
    assert(false, "Should check for flash.")
  end

  test "should show degree" do
    get :show, id: @degree.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @degree.to_param
    assert_response :success
  end

  test "should update degree" do
    put :update, id: @degree.to_param, degree: @degree.attributes
    assert_redirected_to degree_path(assigns(:degree))
  end

  test "should not update degree" do
    put :update, id: @degree.to_param, degree: {name: nil}
    assert(false, "Should check for flash.")
  end

  test "should destroy degree" do
    assert_difference('Degree.count', -1) do
      delete :destroy, id: @degree.to_param
    end

    assert_redirected_to degrees_path
  end
end
