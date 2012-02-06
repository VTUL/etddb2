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
    assert provenance.errors[:creator].any?
    assert provenance.errors[:notice].any?
  end

  test "invalid without all required attributes" do
    attrs = {:creator => 'someone', :notice => 'something'}

    for key, value in attrs do
      provenance = Provenance.new(attrs)
      provenance[key] = nil
      assert !provenance.valid?
      assert provenance.errors[key].any?
    end
  end
end
