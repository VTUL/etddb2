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

  # The three tests below are relics from before Devise was handling
  # authentication. They are left here for completeness, and laziness.

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end

  #test "should create person" do
  #  assert_difference('Person.count') do
  #    @person_attrs = @person.attributes
  #    @person_attrs[:email] = "unique001@example.com"
  #    @person_attrs[:pid] = "unique001"
  #    @person_attrs[:password] = "123456"
  #    post :create, person: @person_attrs
  #  end
  #
  #  assert_redirected_to person_path(assigns(:person))
  #end

  #test "should not create person" do
  #  assert_no_difference('Person.count') do
  #    post :create, person: {first_name: "K", last_name: "W"}
  #  end
  #  assert_select "div#error_explanation"
  #end

  test "should show person" do
    get :show, id: @person.to_param
    assert_response :success
  end

  #test "should get edit" do
  #  get :edit, id: @person.to_param
  #  assert_response :success
  #end

  #test "should update person" do
  #  put :update, id: @person.to_param, person: @person.attributes
  #  assert_redirected_to person_path(assigns(:person))
  #end

  #test "should not update person" do
  #  put :update, id: @person.to_param, person: {email: nil}
  #  assert_select "div#error_explanation"
  #end

  #test "should destroy person" do
  #  assert_difference('Person.count', -1) do
  #    delete :destroy, id: @person.to_param
  #  end
  #
  #  assert_redirected_to people_path
  #end

  test "should get committee search page." do
    post :find, etd_id: etds(:one).to_param, origin: "/etds/"
    assert_response :success
    assert_select "form#committee_search"
  end

  test "should have people to add to your committee." do
    post :find, etd_id: etds(:one).to_param, origin: "/etds/", lname: "k"
    assert_response :success
    assert_select "form#committee_add" do
      assert_select "table"
    end
  end

  test "should get the committee search page, and have people to add." do
    post :new_committee_member, etd_id: etds(:one).to_param, origin: "/etds/", lname: "k"
    assert_response :success
    assert_select "form#committee_add" do
      assert_select "table"
    end
  end

  test "should add a committee member." do
    assert_difference('Etd.find(etds(:one).to_param).people_roles.count') do
      post :add_committee, etd_id: etds(:one).to_param, origin: "/etds/", committee: people(:one).id, committee_type: "Committee Member"
    end
    assert_redirected_to etd_path(etds(:one))
  end
end
