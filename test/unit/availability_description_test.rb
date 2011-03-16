#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class AvailabilityDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.

   test "should be invalid with empty attributes" do

      availability_description = AvailabilityDescription.new

      assert availability_description.invalid?

      assert availability_description.errors[:availability].any?
      assert availability_description.errors[:description].any?
   end
end
