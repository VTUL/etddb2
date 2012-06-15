require 'test_helper'

class PeopleRolesControllerTest < ActionController::TestCase
  setup do
    @people_role = people_roles(:three)
  end

  test "should get index" do
    get(:index)
    assert_response(:success)
    assert_not_nil(assigns(:people_roles))
  end

  test "should get new" do
    get(:new)
    assert_response(:success)
  end

  test "should create people_role" do
    assert_difference('PeopleRole.count') do
      post(:create, people_role: @people_role.attributes)
    end

    assert_redirected_to(people_role_path(assigns(:people_role)))
  end

  test "should not create people_role" do
    assert_no_difference('PeopleRole.count') do
      post(:create, people_role: {})
    end
    assert_select("div#error_explanation")
  end

  test "should show people_role" do
    get(:show, id: @people_role.to_param)
    assert_response(:success)
  end

  test "should get edit" do
    get(:edit, id: @people_role.to_param)
    assert_response(:success)
  end

  test "should update people_role" do
    put(:update, id: @people_role.to_param, people_role: {person_id: 3})
    assert_redirected_to(people_role_path(assigns(:people_role)))
  end

  test "should not update people_role" do
    put(:update, id: @people_role.to_param, people_role: {person_id: nil})
    assert_select("div#error_explanation")
  end

  test "should destroy people_role" do
    assert_difference('PeopleRole.count', -1) do
      delete(:destroy, id: @people_role.to_param)
    end

    assert_redirected_to(people_roles_path)
  end
end
