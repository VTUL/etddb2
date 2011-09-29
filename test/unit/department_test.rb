#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  fixtures :departments
  # Replace this with your real tests.

  test "invalid with empty attributes" do
    department = Department.new
    #puts "adld#{department.name}\n"
    assert !department.valid?
    assert department.errors[:name].any?

  end

  test "invalid with exceptional attributes" do
    department1 = Department.new(:name => departments(:one).name)
    #puts "adld#{department1.name}\n"
    #puts "name#{department1.name}\n"
    #assert !department1.invalid?
    #assert !department1.errors[:name].any?

    department2 = Department.new(:name => departments(:two).name)

    #puts "2adld#{department2.name}\n"
    #assert department2.valid?
    #assert department2.errors[:name].any?
  end
end
