require 'test_helper'

class CopyrightStatementsControllerTest < ActionController::TestCase
  setup do
    @copyright = CopyrightStatement.first
    @person = Person.first
    sign_in(@person)
  end

  test "should get index" do
    get(:index)
    assert_response(:success)
    assert_not_nil(assigns(:copyright_statements))
  end

  test "should get new" do
    get(:new)
    assert_response(:success)
  end

  test "should create copyright_statement" do
    assert_difference('CopyrightStatement.count') do
      post(:create, copyright_statement: @copyright.attributes)
    end

    assert_redirected_to(copyright_statement_path(assigns(:copyright_statement)))
  end

  test "should not create copyright_statement" do
    assert_no_difference('CopyrightStatement.count') do
      post(:create, copyright_statement: {})
    end
    assert_select("div#error_explanation")
  end

  test "should show copyright_statement" do
    get(:show, id: @copyright.to_param)
    assert_response(:success)
  end

  test "should get edit" do
    get(:edit, id: @copyright.to_param)
    assert_response(:success)
  end

  test "should update copyright_statement" do
    put(:update, id: @copyright.to_param, copyright_statement: {})
    assert_redirected_to(copyright_statement_path(assigns(:copyright_statement)))
  end

  test "should not update copyright_statement" do
    put(:update, id: @copyright.to_param, copyright_statement: {statement: nil})
    assert_select("div#error_explanation")
  end

  test "should destroy copyright_statement" do
    assert_difference('CopyrightStatement.count', -1) do
      delete(:destroy, id: @copyright.to_param)
    end

    assert_redirected_to(copyright_statements_path)
  end
end
