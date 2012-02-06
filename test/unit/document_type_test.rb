require 'test_helper'

class DocumentTypeTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    doc_type = DocumentType.new
    assert doc_type.invalid?
    assert doc_type.errors[:name].any?
    assert doc_type.errors[:retired].any?
  end

  test "should be invalid without all required attributes" do
    attrs = {:name => 'name', :retired => false}

    for key, value in attrs do
      doc_type = DocumentType.new(attrs)
      doc_type[key] = nil
      assert !doc_type.valid?
      assert doc_type.errors[key].any?
    end
  end
end
