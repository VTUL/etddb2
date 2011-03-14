require 'test_helper'

class URNsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create urn" do
    assert_difference('URN.count') do
      post :create, :urn => { }
    end

    assert_redirected_to urn_path(assigns(:urn))
  end

  test "should show urn" do
    get :show, :id => urns(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => urns(:one).to_param
    assert_response :success
  end

  test "should update urn" do
    put :update, :id => urns(:one).to_param, :urn => { }
    assert_redirected_to urn_path(assigns(:urn))
  end

  test "should destroy urn" do
    assert_difference('URN.count', -1) do
      delete :destroy, :id => urns(:one).to_param
    end

    assert_redirected_to urns_path
  end
end
