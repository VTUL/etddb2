require 'test_helper'

class PrivacyStatementsControllerTest < ActionController::TestCase
  setup do
    @privacy_statement = privacy_statements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:privacy_statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create privacy_statement" do
    assert_difference('PrivacyStatement.count') do
      post :create, privacy_statement: @privacy_statement.attributes
    end

    assert_redirected_to privacy_statement_path(assigns(:privacy_statement))
  end

  test "should not create privacy_statement" do
    assert_no_difference('PrivacyStatement.count') do
      post :create, privacy_statement: {}
    end
    assert(false, "Should check for flash.")
  end

  test "should show privacy_statement" do
    get :show, id: @privacy_statement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @privacy_statement.to_param
    assert_response :success
  end

  test "should update privacy_statement" do
    put :update, id: @privacy_statement.to_param, privacy_statement: @privacy_statement.attributes
    assert_redirected_to privacy_statement_path(assigns(:privacy_statement))
  end

  test "should not update privacy_statement" do
    put :update, id: @privacy_statement.to_param, privacy_statement: {statement: nil}
    assert(false, "Should check for flash.")
  end

  test "should destroy privacy_statement" do
    assert_difference('PrivacyStatement.count', -1) do
      delete :destroy, id: @privacy_statement.to_param
    end

    assert_redirected_to privacy_statements_path
  end
end
