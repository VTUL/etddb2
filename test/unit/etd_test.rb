require 'test_helper'

class EtdTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors[:abstract].any?
    assert etd.errors[:bound].any?
    assert etd.errors[:copyright_statement_id].any?
    assert etd.errors[:degree_id].any?
    assert etd.errors[:document_type_id].any?
    assert etd.errors[:title].any?
    assert etd.errors[:privacy_statement_id].any?
    assert etd.errors[:release_manager_id].any?
    assert etd.errors[:url].any?
    assert etd.errors[:urn].any?
  end

  test "invalid with non-unique urn." do
    etd = Etd.first
    etd.urn = Etd.last.urn
    assert !etd.valid?
    assert etd.errors[:urn].include?("has already been taken")
    etd.urn = Etd.first.urn
    assert etd.valid?
  end

  test "invalid with non-boolean bound attribute." do
    etd = Etd.first
    etd.bound = nil
    assert !etd.valid?
    assert etd.errors[:bound].include?("must be boolean")
    etd.bound = false
    assert etd.valid?
  end
end
