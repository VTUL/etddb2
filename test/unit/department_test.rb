require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  fixtures :departments
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "invalid with empty attributes" do
    department = Department.new(:name => departments(:one).name)
    #department = Department.new
    puts "adld#{department.name}"
    assert !department.valid?
    assert department.errors[:name].any?
 
#    department = Department.new(:name => departments(:two).name)
    #department = Department.new
#    puts "2adld#{department.name}"
#    assert !department.valid?
#    assert department.errors[:name].any?
  end
end
