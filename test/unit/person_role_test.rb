#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class PersonRoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    person_role = PersonRole.new
    assert !person_role.valid?
    assert person_role.errors[:person_id].any?
    assert person_role.errors[:role_id].any?
  end
end
