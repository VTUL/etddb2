require 'test_helper'

class ProvenancesControllerTest < ActionController::TestCase
  setup do
    @provenance = provenances(:one)
  end

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
      post :create, provenance: @provenance.attributes
    end

    assert_redirected_to provenance_path(assigns(:provenance))
  end

  test "should not create provenance" do
    assert_no_difference('Provenance.count') do
      post :create, provenance: {}
    end
    assert_select "div#error_explanation"
  end

  test "should show provenance" do
    get :show, id: @provenance.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provenance.to_param
    assert_response :success
  end

  test "should update provenance" do
    put :update, id: @provenance.to_param, provenance: @provenance.attributes
    assert_redirected_to provenance_path(assigns(:provenance))
  end

  test "should not update provenance" do
    put :update, id: @provenance.to_param, provenance: {notice: nil}
    assert_select "div#error_explanation"
  end

  test "should destroy provenance" do
    assert_difference('Provenance.count', -1) do
      delete :destroy, id: @provenance.to_param
    end

    assert_redirected_to provenances_path
  end
end
