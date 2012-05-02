require 'test_helper'

class EtddbMailerTest < ActionMailer::TestCase
  test "should send submittal emails." do
    assert(false, "under construction.")
    p = people(:one)
    email = ApprovalMailer.confirm(p).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [p.email], email.to
    assert_equal "Confirmed.", email.subject
    assert_match(/Hello #{p.first_name}!/, email.encoded)
  end
end
