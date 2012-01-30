require 'test_helper'

class PermissionsControllerTest < ActionController::TestCase
  setup do
    @permission = permissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
    assert_not_nil assigns(:digital_objects)
    assert_not_nil assigns(:actions)
  end

  test "should get edit" do
    get :edit, id: @permission.to_param
    assert_response :success
  end

  test "should update permission" do
    assert false, "This needs a rewrite."
  end
end
