require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    avail = Availability.new
    assert avail.invalid?
    assert avail.errors[:name].any?
    assert avail.errors[:description].any?
    assert avail.errors[:retired].any?
  end

  test "should be invalid without all required attributes" do
    # This picks up attributes that don't exist in the yml. Other models don't have this problem.
    # attrs = availabilities(:one).attributes
    attrs = {:name => "Name", :description => "Desc", :retired => false}

    for key, value in attrs do
      avail = Availability.new(attrs)
      avail[key] = nil
      assert !avail.valid?, key.to_s + ": " + avail.errors[key].to_s
      assert avail.errors[key].any?
    end
  end
end
