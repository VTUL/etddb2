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
  end

  test "invalid without all required attributes" do
    attrs = {:first_name => 'f', :last_name => 'l', :email => 'example@example.com', :pid => 'a_pid01'}

    for key, value in attrs do
      person = Person.new(attrs)
      person[key] = nil
      assert !person.valid?
      assert person.errors[key].any?

      if key == 'pid' || key == 'email'
        # Make sure the uniqueness condition is not the only one violated.
        assert etd.errors[key].count("has already been taken") < etd.errors[key].count
      end
    end
  end

  test "invalid with non-unique pid" do
    person = Person.new(people(:one).attributes)
    person.email = "unique@example.com"
    assert !person.valid?
    assert person.errors[:pid].include?("has already been taken")
    #person.pid = "unique1"
    #assert person.valid?
  end

  test "invalid with non-unique email" do
    person = Person.new(people(:one).attributes)
    person.pid = "unique1"
    assert !person.valid?
    assert person.errors[:email].include?("has already been taken")
    #person.email = "unique@example.com"
    #assert person.valid?
  end
end
