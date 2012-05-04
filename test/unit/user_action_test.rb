#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class UserActionTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    user_action = UserAction.new
    assert !user_action.valid?
    assert user_action.errors[:name].any?
  end
end
