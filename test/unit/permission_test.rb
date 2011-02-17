require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "invalid with empty attributes" do
    permission = Permission.new
    assert !permission.valid?
    assert permission.errors.invalid?(:name)
  end
end
