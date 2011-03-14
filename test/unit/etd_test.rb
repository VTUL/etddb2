require 'test_helper'
#module test_helper

class EtdTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors[:degree].any?
    assert etd.errors[:department].any?
    assert etd.errors[:dtype].any?
    assert etd.errors[:title].any?
    assert etd.errors[:abstract].any?
    assert etd.errors[:availability].any?
    assert etd.errors[:department].any?
    assert etd.errors[:availability_description].any?
    assert etd.errors[:copyright_statement].any?
    assert etd.errors[:ddate].any?
    assert etd.errors[:sdate].any?
    assert etd.errors[:adate].any?
    assert etd.errors[:cdate].any?
    assert etd.errors[:rdate].any?
    assert etd.errors[:pid].any?
    assert etd.errors[:url].any?
    assert etd.errors[:timestamp].any?
    assert etd.errors[:bound].any?
    assert etd.errors[:created_at].any?
    assert etd.errors[:updated_at].any?
    assert etd.errors[:committee_chair_id].any?
    assert etd.errors[:author_id].any?
    assert etd.errors[:urn].any?
  end 
end
