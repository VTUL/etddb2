require 'test_helper'

class ApprovalMailerTest < ActionMailer::TestCase

  tests ApprovalMailer

  def setup
    @person = Person.new(:name => "Sung Hee Park", :email=> "hellosunghee@gmail.com")
  end

  
  def test_confirm
    response = ApprovalMailer.create_confirm(@person)
    assert_equal("hellosunghee@gmail.com", response.to[0])
    assert_equal(/Dear Sung Hee Park/, response.body)
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
