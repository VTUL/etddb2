#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class CopyrightStatementTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    copyright_statement = CopyrightStatement.new

    assert copyright_statement.invalid?
    assert copyright_statement.errors[:description].any?
    #puts copyright_statement.errors[:description]
  end
end
