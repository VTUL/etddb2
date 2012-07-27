require 'test_helper'

class DegreeTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    degree = Degree.new
    assert degree.invalid?
    assert degree.errors[:name].any?
    assert degree.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    degree = Degree.first
    degree.retired = nil
    assert !degree.valid?
    assert degree.errors[:retired].include?("must be boolean")
    degree.retired = false
    assert degree.valid?
  end
end
