require 'test_helper'
#module test_helper

class EtdTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors[:abstract].any?
    assert etd.errors[:availability_id].any?
    assert etd.errors[:bound].any?
<<<<<<< HEAD
    #assert etd.errors[:degree].any?
    assert etd.errors[:department].any?
    assert etd.errors[:dtype].any?
=======
    assert etd.errors[:copyright_statement_id].any?
    assert etd.errors[:degree_id].any?
    assert etd.errors[:document_type_id].any?
>>>>>>> 4fce0655f41200f9952f807e5a21314182331c05
    assert etd.errors[:title].any?
    assert etd.errors[:privacy_statement_id].any?
    assert etd.errors[:url].any?
    assert etd.errors[:urn].any?
  end

  test "invalid without all required attributes" do
<<<<<<< HEAD
    attrs = {:title => 'test', :abstract => 'abs', :bound => 'false', :urn => 'etd-1',
             :url => 'http://etds.edu/etd-1/', :dtype => 'Thesis', :department => 'Art Theory',
             #:degree => 'Master of Theory',
             :availability => 'withheld'}
=======
    attrs = {:abstract => 'abs', :availability_id => 1, :bound => false,
             :copyright_statement_id => 1, :degree_id => 1, :document_type_id => 1,
             :title => 'test', :url => 'http://etds.edu/etd-1/', :urn => 'etd-1'}
>>>>>>> 4fce0655f41200f9952f807e5a21314182331c05

    for key, value in attrs do
      etd = Etd.new(attrs)
      etd[key] = ''
      assert !etd.valid?
    end
  end
end
