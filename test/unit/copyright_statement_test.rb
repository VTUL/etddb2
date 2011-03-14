require 'test_helper'

class CopyrightStatementTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "should be invalid with empty attributes" do
    copyright_statement = CopyrightStatement.new
    assert copyright_statement = CopyrightStatement.new
    assert copyright_statement.errors[:description].any?
    assert copyright_statement.errors[:created_at].any?
    assert copyright_statement.errors[:updated-at].any?
    assert copyright_statement.errors[:etd_id].any?
  end
end
