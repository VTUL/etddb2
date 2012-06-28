#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class ProvenanceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be invalid with empty attributes" do
    provenance = Provenance.new
    assert !provenance.valid?
    assert provenance.errors[:person].any?
    assert provenance.errors[:action].any?
    assert provenance.errors[:model].any?
  end
end
