#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    department = Department.new
    assert !department.valid?
    assert department.errors[:name].any?
    assert department.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    deparment = Department.first
    deparment.retired = nil
    assert !deparment.valid?
    assert deparment.errors[:retired].include?("must be boolean")
    deparment.retired = false
    assert deparment.valid?
  end
end
