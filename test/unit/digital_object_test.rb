require 'test_helper'

class DigitalObjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "invalid with empty attributes" do
    digital_object = DigitalObject.new
    assert !digital_object.valid?
    assert digital_object.errors.invalid?(:name)
    assert digital_object.errors.invalid?(:created_at)
    assert digital_object.errors.invalid?(:updated_at)
  end
end
