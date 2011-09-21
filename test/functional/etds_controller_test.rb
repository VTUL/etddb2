require 'test_helper'

class EtdsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:etds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create etd" do
    assert_difference('Etd.count') do
      post :create, :etd => {:urn=>"123456789" }
    end

    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should show etd" do
    get :show, :id => etds(:SungHeePark).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => etds(:SungHeePark).to_param
    assert_response :success
  end

  test "should update etd" do
    put :update, :id => etds(:SungHeePark).to_param, :etd => { }
    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should destroy etd" do
    assert_difference('Etd.count', -1) do
      delete :destroy, :id => etds(:SungHeePark).to_param
    end

    assert_redirected_to etds_path
  end
end
