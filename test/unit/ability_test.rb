require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test "user can only destroy projects which he owns" do
    @user = Person.first
    @role = Role.find(:first, conditions: "name='Author'") || Role.new(name: 'Author')
    @user_role = PeopleRole.new(person_id: @user.id, role_id: @role.id)
    @an_etd = Etd.new(abstract: 'abs', availability_id: 1, bound: false,
                      copyright_statement_id: 1, degree_id: 1, document_type_id: 1,
                      title: 'test', url: 'http://etds.edu/etd-1/', urn: 'etd-1')
    @an_etd.people_roles << @user_role

    ability = Ability.new(@user)
    assert ability.can?(:Destroy, @an_etd), "Unable to destroy an etd that you authored."
    assert ability.cannot?(:Destroy, Etd.new), "Able to destroy an etd even if you don't own it."
  end

end