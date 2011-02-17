require 'test_helper'

class DocTypeDescriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "invalid with empty attributes" do
    doc_type_desc = DocTypeDescription.new
    assert !doc_type_desc.valid?
    assert doc_type_desc.errors.invalid?(:name)
  end
end
