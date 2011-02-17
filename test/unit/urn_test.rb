require 'test_helper'

class UrnTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "invalid with empty attributes" do
    urn = Urn.new
    assert !urn.valid?
    assert urn.errors.invalid?(:urn)
  end
end
