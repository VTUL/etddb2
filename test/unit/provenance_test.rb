require 'test_helper'

class ProvenanceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    provenance = Provenance.new
    assert !provenance.valid?
    assert provenance.errors[:creator].any?
    assert provenance.errors[:notice].any?
  end
end
