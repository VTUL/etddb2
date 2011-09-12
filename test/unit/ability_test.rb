require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test "user can only destroy projects which he owns" do
    user = Person.create!
    ability = Ability.new(user)
    role = Role.new
    role.name="Author"
    role.save
    user_role = PeopleRole.new(:person_id => user.id,:role_id => role.id)
    assert ability.can?(:destroy, Etd.new(:people_roles => user_role))
    assert ability.cannot?(:destroy, Etd.new)
  end

end
