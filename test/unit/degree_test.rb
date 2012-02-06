require 'test_helper'

class DegreeTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    degree = Degree.new
    assert degree.invalid?
    assert degree.errors[:name].any?
    assert degree.errors[:retired].any?
  end

  test "should be invalid without all required attributes" do
    attrs = {:name => 'name', :retired => false}

    for key, value in attrs do
      degree = Degree.new(attrs)
      degree[key] = nil
      assert !degree.valid?
      assert degree.errors[key].any?
    end
  end
end
