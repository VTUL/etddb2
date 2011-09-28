require 'test_helper'

class EtdsControllerTest < ActionController::TestCase
  def setup
    @etd = etds(:one)
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
      post :create, :etd => {:degree => "PhD", :department => "Computer Science", :dtype => "dissertation", :title => "Test:", :abstract => "This is a test abstract", :urn => 0,
                             :availability => "unrestricted", :pid => "shpark", :url => "http://scholar.lib.vt.edu/theses/available/etd-07292010-14030054/", :bound => "NO"}
  end

    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should show etd" do
    get :show, :id => etds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => etds(:one).to_param
    assert_response :success
  end

  test "should update etd" do
    put :update, :id => etds(:one).to_param, :etd => {:urn=>"223456789" }
    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should destroy etd" do
    assert_difference('Etd.count', -1) do
      delete :destroy, :id => etds(:one).to_param
    end

    assert_redirected_to etds_path
  end
end
