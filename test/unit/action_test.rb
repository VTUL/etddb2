require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "invalid with empty attributes" do
    action = Action.new
    assert !action.valid?
    assert action.errors.invalid?(:name)
  end
end
