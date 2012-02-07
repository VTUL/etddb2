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

  test "should be invalid without all required attributes" do
    attrs = {:name => 'name', :retired => false}

    for key, value in attrs do
      department = Department.new(attrs)
      department[key] = nil
      assert !department.valid?
      assert department.errors[key].any?
    end
  end
end
