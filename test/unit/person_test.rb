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
    assert person.errors[:first_name].any?, "No errors for missing first name."
    assert person.errors[:last_name].any?,  "No errors for missing last name."
    assert person.errors[:email].any?,  "No errors for missing last name."
    assert person.errors[:pid].any?,  "No errors for missing pid."
    assert person.errors[:password].any?, "No errors for missing password"
  end

  test "invalid with non-unique pid" do
    person = Person.first
    # Fix the other errors that should show up after loading an existing person.
    person.pid = Person.last.pid
    assert !person.valid?
    assert person.errors[:pid].include?("has already been taken")
    person.pid = "unique001"
    assert person.valid?
  end

  test "invalid with non-unique email" do
    person = Person.first
    # Fix the other errors that should show up after loading an existing person.
    person.email = Person.last.email
    assert !person.valid?
    assert person.errors[:email].include?("has already been taken")
    person.email = "unique001@example.com"
    assert person.valid?
  end
end
