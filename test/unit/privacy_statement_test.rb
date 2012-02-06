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

  test "invalid without all required attributes" do
    attrs = {:statement => 'words', :retired => false}

    for key, value in attrs do
      statement = PrivacyStatement.new(attrs)
      statement[key] = nil
      assert !statement.valid?
      assert statement.errors[key].any?
    end
  end
end
