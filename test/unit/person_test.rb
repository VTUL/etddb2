#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    person = Person.new
   
    assert !person.valid?
    assert person.errors[:role].any? 
    assert person.errors[:first_name].any? 
    assert person.errors[:last_name].any? 
    assert person.errors[:email].any? 
    assert person.errors[:pid].any? 
  end
end
