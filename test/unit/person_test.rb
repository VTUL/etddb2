require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    person = Person.new
   
    assert !etd.valid?
    assert etd.errors[:role].any? 
    assert etd.errors[:first_name].any? 
    assert etd.errors[:middle_name].any? 
    assert etd.errors[:last_name].any? 
    assert etd.errors[:email].any? 
    assert etd.errors[:pid].any? 
    assert etd.errors[:suffix].any? 
    assert etd.errors[:created_at].any? 
    assert etd.errors[:updated_at].any? 
    assert etd.errors[:roles_mask].any? 
  end
end
