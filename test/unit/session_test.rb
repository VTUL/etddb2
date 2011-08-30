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

  test "should be valid with data and session_id attributes" do
    session = Session.new(:session_id => 1, :data => "shpark")
    assert session.valid?
    assert !session.errors[:session_id].any?
    assert !session.errors[:data].any?
  end
end
