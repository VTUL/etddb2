require 'test_helper'

class CopyrightStatementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:copyright_statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create copyright_statement" do
    assert_difference('CopyrightStatement.count') do
      post :create, :copyright_statement => {:statement => "Blah, Blah", :retired => true }
    end

    assert_redirected_to copyright_statement_path(assigns(:copyright_statement))
  end

  test "should show copyright_statement" do
    get :show, :id => copyright_statements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => copyright_statements(:one).to_param
    assert_response :success
  end

  test "should update copyright_statement" do
    put :update, :id => copyright_statements(:one).to_param, :copyright_statement => { }
    assert_redirected_to copyright_statement_path(assigns(:copyright_statement))
  end

  test "should destroy copyright_statement" do
    assert_difference('CopyrightStatement.count', -1) do
      delete :destroy, :id => copyright_statements(:one).to_param
    end

    assert_redirected_to copyright_statements_path
  end
end
