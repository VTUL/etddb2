require 'test_helper'
#module test_helper

class EtdTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    etd = Etd.new
    assert !etd.valid?
    assert etd.errors.invalid?[:title].any?
    assert etd.errors.invalid?[:description].any?
    assert etd.errors.invalid?[:price].any?
  end 
end
