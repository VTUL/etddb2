require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    session = Session.new
    assert !session.valid?
    assert session.errors[:session_id].any?
    assert session.errors[:data].any?
    assert session.errors[:created_at].any?
    assert session.errors[:updated_at].any?
  end
end
