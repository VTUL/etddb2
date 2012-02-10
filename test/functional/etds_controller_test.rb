require 'test_helper'

class EtdsControllerTest < ActionController::TestCase
  setup do
    @etd = etds(:one)
    @person = people(:one)
    sign_in @person
  end

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
      @etd_attrs = @etd.attributes
      @etd_attrs[:urn] = 0
      post :create, etd: @etd_attrs
    end

    assert_redirected_to next_new_etd_path(assigns(:etd))
  end

  test "should get next_new" do
    get :next_new, id: @etd.to_param
    assert_response :success
    assert_not_nil assigns(:etd)
  end

  test "should show etd" do
    get :show, id: @etd.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @etd.to_param
    assert_response :success
  end

  test "should update etd" do
    put :update, id: @etd.to_param, etd: @etd.attributes
    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should destroy etd" do
    assert_difference('Etd.count', -1) do
      delete :destroy, id: @etd.to_param
    end

    assert_redirected_to :controller => "etds", :action => "index", :notice => "ETD Deleted."
  end
end
