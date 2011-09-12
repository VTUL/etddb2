require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test "user can only destroy projects which he owns" do
    user = Person.create!
    role = Role.new
    role.name="Author"    
    role.save
    user_role = PersonRole.new(:person_id => user.id,:role_id => role.id)
    ability = Ability.new(user)
    assert ability.can?(:destroy, Etd.new(:people_roles => user_role))
    assert ability.cannot?(:destroy, Etd.new)
  end

end
