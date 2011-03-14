require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "user can only destroy projects which he owns" do
    user = Person.create!
    ability = Ability.new(user)
    assert ability.can?(:destroy, Etd.new(:user => user))
    assert ability.cannot?(:destroy, Etd.new)
  end

end

