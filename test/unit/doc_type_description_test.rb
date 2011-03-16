#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class DocTypeDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    doc_type_desc = DocTypeDescription.new
    assert !doc_type_desc.valid?
    assert doc_type_desc.errors[:name].any?
  end
end
