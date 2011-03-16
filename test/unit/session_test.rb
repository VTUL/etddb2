#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    session = Session.new
    assert !session.valid?
    assert session.errors[:session_id].any?
    assert session.errors[:data].any?
  end
end
