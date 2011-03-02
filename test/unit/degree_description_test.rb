require 'test_helper'

class DegreeDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "invalid with empty attributes" do
    degree_description = DegreeDescription.new
    assert !degree_description.valid?
    assert degree_description.errors.invalid?(:name)
    assert degree_description.errors.invalid?(:created_at)
    assert degree_description.errors.invalid?(:updated_at)
  end
end
