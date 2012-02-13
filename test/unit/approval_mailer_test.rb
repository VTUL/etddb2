require 'test_helper'

class ApprovalMailerTest < ActionMailer::TestCase
  tests ApprovalMailer

  def test_confirm
    p = people(:one)
    email = ApprovalMailer.confirm(p).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [p.email], email.to
    assert_equal "Confirmed.", email.subject
    assert_match(/Hello #{p.first_name}!/, email.encoded)
  end
end
