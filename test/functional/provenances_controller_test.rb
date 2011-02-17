require 'test_helper'

class ProvenancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provenance" do
    assert_difference('Provenance.count') do
      post :create, :provenance => { }
    end

    assert_redirected_to provenance_path(assigns(:provenance))
  end

  test "should show provenance" do
    get :show, :id => provenances(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => provenances(:one).to_param
    assert_response :success
  end

  test "should update provenance" do
    put :update, :id => provenances(:one).to_param, :provenance => { }
    assert_redirected_to provenance_path(assigns(:provenance))
  end

  test "should destroy provenance" do
    assert_difference('Provenance.count', -1) do
      delete :destroy, :id => provenances(:one).to_param
    end

    assert_redirected_to provenances_path
  end
end
