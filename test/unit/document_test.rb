#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    document = Document.new
    assert document.invalid?
    assert document.errors[:page_count].any?

  # These following attributes are inherited
  # from the parent class "Content"
    assert document.errors[:uploaded_file_name].any?
    assert document.errors[:uploaded_content_type].any?
    assert document.errors[:uploaded_file_size].any?
    assert document.errors[:availability].any?
    #assert document.errors[:bound].any?
    assert document.errors[:page_count].any?
  end
end
