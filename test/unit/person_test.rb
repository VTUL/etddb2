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

    assert !person.valid?, "Error: Person is valid with empty attributes."
    #assert person.errors[:role].any?, "No errors for missing role."
    assert person.errors[:first_name].any?, "No errors for missing first name."
    assert person.errors[:last_name].any?,  "No errors for missing last name."
    assert person.errors[:email].any?,  "No errors for missing last name."
    assert person.errors[:pid].any?,  "No errors for missing pid."
  end
end
