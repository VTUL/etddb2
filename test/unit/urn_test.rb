#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class UrnTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes" do
    urn = Urn.new
    assert !urn.valid?
    assert urn.errors[:urn].any?
    assert urn.errors[:id].any?
  end
end
