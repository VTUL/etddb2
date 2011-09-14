require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test "user can only destroy projects which he owns" do
    user = Person.create(:first_name => "Collin", :last_name => "Brittle", :email => "rotated8@vt.edu", :pid => "rotated8")
    ability = Ability.new(user)

    role = Role.new(:name => "Author")
    user_role = PeopleRole.new(:person_id => user.id,:role_id => role.id)
    an_etd = Etd.new
    an_etd.people_roles << user_role
    assert ability.can?(:destroy, an_etd), "Unable to destroy an etd that you authored."
    assert ability.cannot?(:destroy, Etd.new), "Able to destroy an etd even if you don't own it."
  end

end
