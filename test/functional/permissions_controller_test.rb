require 'test_helper'

class PermissionsControllerTest < ActionController::TestCase
  setup do
    @person = Person.first
    sign_in(@person) 
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
    assert_not_nil assigns(:digital_objects)
    assert_not_nil assigns(:actions)
  end

  test "should get edit" do
    get :edit
    assert_response :success
    assert_not_nil assigns(:roles)
    assert_not_nil assigns(:digital_objects)
    assert_not_nil assigns(:actions)
  end

  test "should update permission" do
    old_perms = Set[]
    for perm in Permission.all
      old_perms << "#{perm.role_id}_#{perm.digital_object_id}_#{perm.user_action_id}"
    end

    @perm_params = {}
    for perm in old_perms
      @perm_params[perm] = "true"
    end

    if @perm_params.has_key?("6_9_4")
      assert(false, "Our 'new' permission is already taken.")
    end

    @perm_params["6_9_4"] = "true"

    assert_difference('Permission.count') do
      post :update, perms: @perm_params
    end
    
    assert_redirected_to permissions_path

    @perm_params["6_9_4"] = "false"

    assert_difference('Permission.count', -1) do
      post :update, perms: @perm_params
    end

    assert_redirected_to permissions_path
  end
end
