require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      @person_attrs = @person.attributes
      @person_attrs[:email] = "unique001@example.com"
      @person_attrs[:pid] = "unique001"
      @person_attrs[:password] = "123456"
      post :create, person: @person_attrs
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should not create person" do
    assert_no_difference('Person.count') do
      post :create, person: {first_name: "K", last_name: "W"}
    end
    assert(false, "Should check for flash.")
  end

  test "should show person" do
    get :show, id: @person.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person.to_param
    assert_response :success
  end

  test "should update person" do
    put :update, id: @person.to_param, person: @person.attributes
    assert_redirected_to person_path(assigns(:person))
  end

  test "should not update person" do
    put :update, id: @person.to_param, person: {email: nil}
    assert(false, "Should check for flash.")
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person.to_param
    end

    assert_redirected_to people_path
  end

  test "should get committee search page." do
    assert(false, "TODO")
  end

  test "should add a committee member." do
    assert(false, "TODO")
  end

end
