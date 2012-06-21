require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
    sign_in @person
  end

  test "should get index" do
    get(:index)
    assert_response(:success)
    assert_not_nil(assigns(:people))
  end

  test "should show person" do
    get(:show, id: @person.to_param)
    assert_response(:success)
  end

  test "should get committee search page." do
    post(:find, etd_id: etds(:one).to_param, origin: "/etds/")
    assert_response(:success)
    assert_select("form#committee_search")
  end

  test "should have people to add to your committee." do
    post(:find, etd_id: etds(:one).to_param, origin: "/etds/", lname: "k")
    assert_response(:success)
    assert_select("form#committee_add") do
      assert_select("table")
    end
  end

  test "should get the committee search page, and have people to add." do
    post(:new_committee_member, etd_id: etds(:one).to_param, origin: "/etds/", lname: "k")
    assert_response(:success)
    assert_select("form#committee_add") do
      assert_select("table")
    end
  end

  test "should add a committee member." do
    assert_difference('Etd.find(etds(:one).to_param).people_roles.count') do
      post(:add_committee, etd_id: etds(:one).to_param, origin: "/etds/", committee: people(:one).id, committee_type: "Committee Member")
    end
    assert_redirected_to etd_path(etds(:one))
  end
end
