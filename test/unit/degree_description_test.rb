#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DegreeDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    degree_description = DegreeDescription.new
    assert !degree_description.valid?
    assert degree_description.errors[:id].any?
    assert degree_description.errors[:name].any?
  end
end
