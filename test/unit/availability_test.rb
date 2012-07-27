require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    avail = Availability.new
    assert avail.invalid?
    assert avail.errors[:name].any?
    assert avail.errors[:description].any?
    assert avail.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    avail = Availability.first
    avail.retired = nil
    assert !avail.valid?
    assert avail.errors[:retired].include?("must be boolean")
    avail.retired = false
    assert avail.valid?
  end
end
