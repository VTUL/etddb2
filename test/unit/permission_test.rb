#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    permission = Permission.new
    assert !permission.valid?
    assert permission.errors[:role_id].any?
    assert permission.errors[:user_action_id].any?
    assert permission.errors[:digital_object_id].any?
  end

  test "should be invalid without all required attributes" do
    attrs = {:role_id => 1, :user_action_id => 1, :digital_object_id => 1}

    for key, value in attrs do
      permission = Permission.new(attrs)
      permission[key] = nil
      assert !permission.valid?
      assert permission.errors[key].any?
    end
  end
end
