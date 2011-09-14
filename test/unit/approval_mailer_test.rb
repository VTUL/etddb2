require 'test_helper'

class ApprovalMailerTest < ActionMailer::TestCase

  tests ApprovalMailer

  def setup
    @person = Person.new(:first_name => "Collin", :last_name => "Brittle", :email=> "rotated8@vt.edu")
  end


  def test_confirm
    response = ApprovalMailer.confirm(@person)
    assert_equal("rotated8@vt.edu", response.to[0])
    assert_equal('Confirmed.', response.body.to_s)
  end

#  test "confirm" do
#    @expected.subject = 'ApprovalMailer#confirm'
#    @expected.body    = read_fixture('confirm')
#    @expected.date    = Time.now

#    assert_equal @expected.encoded, ApprovalMailer.create_confirm(@expected.date).encoded
#  end

#  test "sent" do
#    @expected.subject = 'ApprovalMailer#sent'
#    @expected.body    = read_fixture('sent')
#    @expected.date    = Time.now

#    assert_equal @expected.encoded, ApprovalMailer.create_sent(@expected.date).encoded
#  end

end
