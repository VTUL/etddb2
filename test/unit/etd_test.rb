require 'test_helper'

class EtdTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors[:abstract].any?
    assert etd.errors[:availability_id].any?
    assert etd.errors[:bound].any?
    assert etd.errors[:copyright_statement_id].any?
    assert etd.errors[:degree_id].any?
    assert etd.errors[:document_type_id].any?
    assert etd.errors[:title].any?
    assert etd.errors[:privacy_statement_id].any?
    assert etd.errors[:url].any?
    assert etd.errors[:urn].any?
  end

  test "invalid with non-unique urn." do
    etd = Etd.new(etds(:one).attributes)
    assert !etd.valid?
    assert etd.errors[:urn].include?("has already been taken")
    etd.urn = 0
    assert etd.valid?
  end

  test "invalid with non-boolean bound attribute." do
    etd = Etd.new(etds(:one).attributes)
    #The urn will also cause an error, so fix it.
    etd.urn = 0
    etd.bound = nil
    assert !etd.valid?
    assert etd.errors[:bound].include?("must be boolean")
    etd.bound = false
    assert etd.valid?
  end
end
