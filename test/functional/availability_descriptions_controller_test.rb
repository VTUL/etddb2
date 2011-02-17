require 'test_helper'

class AvailabilityDescriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:availability_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create availability_description" do
    assert_difference('AvailabilityDescription.count') do
      post :create, :availability_description => { }
    end

    assert_redirected_to availability_description_path(assigns(:availability_description))
  end

  test "should show availability_description" do
    get :show, :id => availability_descriptions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => availability_descriptions(:one).to_param
    assert_response :success
  end

  test "should update availability_description" do
    put :update, :id => availability_descriptions(:one).to_param, :availability_description => { }
    assert_redirected_to availability_description_path(assigns(:availability_description))
  end

  test "should destroy availability_description" do
    assert_difference('AvailabilityDescription.count', -1) do
      delete :destroy, :id => availability_descriptions(:one).to_param
    end

    assert_redirected_to availability_descriptions_path
  end
end
