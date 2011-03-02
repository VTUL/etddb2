require 'test_helper'

class AvailabilityDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
   test "should be invalid with empty attributes" do
      availability_description = AvailabilityDescription.new
      assert availability_description.invalid?
      assert availability_description.errors[:availability].any?
      assert availability_description.errors[:description].any?
      assert availability_description.errors[:created_at].any?
      assert availability_description.errors[:updated_at].any?
      assert availability_description.errors[:etd_id].any?
end
