#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class CopyrightStatementTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    statement = CopyrightStatement.new
    assert statement.invalid?
    assert statement.errors[:statement].any?
    assert statement.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    statement = CopyrightStatement.first
    statement.retired = nil
    assert !statement.valid?
    assert statement.errors[:retired].include?("must be boolean")
    statement.retired = false
    assert statement.valid?
  end
end
