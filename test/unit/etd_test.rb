require 'test_helper'
#module test_helper

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

  test "invalid without all required attributes" do
    attrs = {:abstract => 'abs', :availability_id => 1, :bound => false,
             :copyright_statement_id => 1, :degree_id => 1, :document_type_id => 1,
             :title => 'title', :privacy_statement_id => 1, :url => "/", :urn => 0}

    for key, value in attrs do
      etd = Etd.new(attrs)
      etd[key] = nil
      assert !etd.valid?
      assert etd.errors[key].any?

      if key == 'urn'
        # Make sure the uniqueness condition is not the only one violated.
        assert etd.errors[key].count("has already been taken") < etd.errors[key].count
      end
    end
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
    etd.bound = nil
    assert !etd.valid?
    assert etd.errors[:bound].include?("must be boolean")
    #etd.bound = false
    #assert etd.valid?
  end
end
