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
    assert urn.errors.invalid?(:created_at)
    assert urn.errors.invalid?(:updated_at)
  end
end
