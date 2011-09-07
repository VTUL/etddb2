#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    action = Action.new
    assert !action.valid?
    assert action.errors[:name].any?
  end
end
