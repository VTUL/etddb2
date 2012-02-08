require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    doc_type = DocumentType.new
    assert doc_type.invalid?
    assert doc_type.errors[:name].any?
    assert doc_type.errors[:retired].any?
  end

  test "invalid with non-boolean retired attribute." do
    doc_type = DocumentType.new(document_types(:one).attributes)
    doc_type.retired = nil
    assert !doc_type.valid?
    assert doc_type.errors[:retired].include?("must be boolean")
    doc_type.retired = false
    assert doc_type.valid?
  end
end
