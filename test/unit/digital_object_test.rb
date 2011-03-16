#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DigitalObjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    digital_object = DigitalObject.new
    assert !digital_object.valid?
    assert digital_object.errors[:name].any?
  end
end
