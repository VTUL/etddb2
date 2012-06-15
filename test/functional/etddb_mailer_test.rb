require 'test_helper'

class EtddbMailerTest < ActionMailer::TestCase
  test "should send submission confirmation to the author." do
    etd = etds(:one)
    author = Person.find(etd.people_roles.where(role_id: Role.where(name: 'Author').first).first.person_id)

    email = EtddbMailer.confirm_submit_author(etd, author).deliver
    assert(!ActionMailer::Base.deliveries.empty?)

    assert_equal([author.email], email.to)
    assert_equal("ETD Successfully Submitted.", email.subject)
    assert_match(/Congratulations, #{author.first_name}!/, email.encoded)
  end
  
  test "should send submission confirmation to the graduate school." do
    etd = etds(:one)
    author = Person.find(etd.people_roles.where(role_id: Role.where(name: 'Author').first).first.person_id)

    email = EtddbMailer.confirm_submit_school(etd, author).deliver
    assert(!ActionMailer::Base.deliveries.empty?)

    assert_equal(['cnbrittle@gmail.com'], email.to)
    assert_equal("New ETD Submitted.", email.subject)
    #TODO: This assert_match should be unique to the grad school submission confirmation email.
    assert_match(/#{author.display_name} just submitted their ETD!/, email.encoded)
  end
  
  test "should send submission confirmation to the committee members." do
    etd = etds(:one)
    author = Person.find(etd.people_roles.where(role_id: Role.where(name: 'Author').first).first.person_id)
    committee_emails = Person.where(id: etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id)).pluck(:email)

    email = EtddbMailer.confirm_submit_committee(etd, author).deliver
    assert(!ActionMailer::Base.deliveries.empty?)

    assert_equal(committee_emails, email.to)
    assert_equal("New ETD Submitted.", email.subject)
    #TODO: This assert_match should be unique to the committee submission confirmation email.
    assert_match(/#{author.display_name} just submitted their ETD!/, email.encoded)
  end
end