require 'test_helper'

class PersonRoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "invalid with empty attributes" do
    person_role = PersonRole.new
    assert !personRole.valid?
    assert personRole.errors.invalid?(:name)
  end
end
