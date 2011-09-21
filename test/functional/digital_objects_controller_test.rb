require 'test_helper'

class DigitalObjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:digital_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create digital_object" do
    assert_difference('DigitalObject.count') do
      post :create, :digital_object => {:name=>"etd" }
    end

    assert_redirected_to digital_object_path(assigns(:digital_object))
  end

  test "should show digital_object" do
    get :show, :id => digital_objects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => digital_objects(:one).to_param
    assert_response :success
  end

  test "should update digital_object" do
    put :update, :id => digital_objects(:one).to_param, :digital_object => { }
    assert_redirected_to digital_object_path(assigns(:digital_object))
  end

  test "should destroy digital_object" do
    assert_difference('DigitalObject.count', -1) do
      delete :destroy, :id => digital_objects(:one).to_param
    end

    assert_redirected_to digital_objects_path
  end
end
