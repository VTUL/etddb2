#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class PrivacyStatementTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    statement = PrivacyStatement.new
    assert statement.invalid?
    assert statement.errors[:statement].any?
    assert statement.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    statement = PrivacyStatement.new(privacy_statements(:one).attributes)
    statement.retired = nil
    assert !statement.valid?
    assert statement.errors[:retired].include?("must be boolean")
    statement.retired = false
    assert statement.valid?
  end
end
