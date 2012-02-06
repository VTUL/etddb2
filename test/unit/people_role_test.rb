#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class PeopleRoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    person_role = PeopleRole.new
    assert !person_role.valid?
    assert person_role.errors[:person_id].any?
    assert person_role.errors[:role_id].any?
  end

  test "should be invalid without all required attributes" do
    attrs = {:person_id => 1, :role_id => 1}

    for key, value in attrs do
      person_role = PeopleRole.new(attrs)
      person_role[key] = nil
      assert !person_role.valid?
      assert person_role.errors[key].any?
    end
  end
end
