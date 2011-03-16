#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class ContentTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  # Assert "validate_presence_of" attributes

  # Even though page_count is in the "contents" table, 
  # it is an attribute of the Document class 
  # Please see the Document class for page_count assertion.

  test "should be invalid with empty attributes" do
    content = Content.new
    assert content.invalid?
    assert content.errors[:filename].any?
    assert content.errors[:types].any?
    assert content.errors[:size].any?
    assert content.errors[:availability].any? 
    assert content.errors[:bound].any? 
  end
end
