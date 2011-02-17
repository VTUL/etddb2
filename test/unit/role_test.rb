require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "invalid with empty attributes" do
    role = Role.new
    assert !role.valid?
    assert role.errors.invalid?(:name)
  end
end
