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
      @etd_attrs[:department_ids] = {:id_1 => 1}
      post :create, etd: @etd_attrs
    end

    assert_redirected_to next_new_etd_path(assigns(:etd))
  end

  test "should not create etd" do
    assert_no_difference('Etd.count') do
      @etd_attrs = {}
      @etd_attrs[:department_ids] = {:id_1 => 1}
      post :create, etd: @etd_attrs
    end
    assert_select "div#error_explanation"
  end

  test "should get next_new" do
    get :next_new, id: @etd.to_param
    assert_response :success
    assert_not_nil assigns(:etd)
  end

  test "should show etd" do
    get :show, id: @etd.to_param
    assert_response :success
    assert_not_nil assigns(:etd)
  end

  test "should get edit" do
    get :edit, id: @etd.to_param
    assert_response :success
    assert_not_nil assigns(:etd)
  end

  test "should update etd" do
    @etd_attrs = @etd.attributes
    @etd_attrs[:department_ids] = {:id_1 => 1}
    put :update, id: @etd.to_param, etd: @etd_attrs
    assert_redirected_to etd_path(assigns(:etd))
  end

  test "should not update etd" do
    @etd_attrs = {title: nil}
    @etd_attrs[:department_ids] = {:id_1 => 1}

    put :update, id: @etd.to_param, etd: @etd_attrs
    assert_select "div#error_explanation"
  end

  test "should be logged in for certain functionality." do
    sign_out @person

    get :new
    assert_redirected_to login_path

    get :my_etds
    assert_redirected_to login_path

    get :edit, id: @etd.to_param
    assert_redirected_to login_path

    delete :destroy, id: @etd.to_param
    assert_redirected_to etds_path
  end

  test "should only be able to edit and destroy your ETDs." do
    sign_out @person
    @person = people(:two)
    sign_in @person

    get :edit, id: @etd.to_param
    assert_redirected_to etds_path

    delete :destroy, id: @etd.to_param
    assert_redirected_to etds_path
  end

  test "should destroy etd" do
    assert_difference('Etd.count', -1) do
      delete :destroy, id: @etd.to_param
    end

    assert_redirected_to :controller => "etds", :action => "index", :notice => "ETD Deleted."
  end

  test "should get my_etds" do
    get :my_etds
    assert_response :success
    assert_not_nil assigns(:authors_etds)
  end

  test "should get add_contents" do
    post :add_contents, id: etds(:one).to_param
    assert_response :success
    assert_not_nil assigns(:etd)
  end

  test "should add multiple contents (save_contents) to an ETD." do
    assert(false, "WIP, CarrierWave is not easy to test.")
    assert_difference('Etd.find(etds(:one).to_param).contents.count') do
      post :next_new, id: etds(:one).to_param, origin: "/etds/add_contents/" #TODO: Add params for CarrierWave content.
    end
    assert_redirected_to add_contents_to_etd_path(etds(:one))
  end

  test "should submit the etd for review." do
    post :submit, id: @etd.to_param
    assert_response :success
  end

end
