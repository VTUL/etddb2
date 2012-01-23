require 'test_helper'
#module test_helper

class EtdTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors[:abstract].any?
    assert etd.errors[:availability].any?
    assert etd.errors[:bound].any?
    assert etd.errors[:degree].any?
    assert etd.errors[:department].any?
    assert etd.errors[:dtype].any?
    assert etd.errors[:title].any?
    assert etd.errors[:url].any?
    assert etd.errors[:urn].any?
  end

  test "invalid without all required attributes" do
    attrs = {:title => 'test', :abstract => 'abs', :bound => 'false', :urn => 'etd-1',
             :url => 'http://etds.edu/etd-1/', :dtype => 'Thesis', :department => 'Art Theory',
             :degree => 'Master of Theory', :availability => 'withheld'}

    for key, value in attrs do
      etd = Etd.new(attrs)
      etd[key] = ''
      assert !etd.valid?
    end
  end
end
