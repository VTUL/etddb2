require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  test "should be invalid with empty attributes" do
    content = Content.new
    assert content.invalid?
    assert content.errors[:filename].any?
    assert content.errors[:types].any?
    assert content.errors[:size].any?
    assert content.errors[:availability].any? 
#    assert content.errors[:bound].any? 
#    assert content.errors[:page_count].any? 
#    assert content.errors[:timestamp].any? 
    #assert content.errors[:created_at].any? 
    assert content.errors[:updated_at].any? 
    assert content.errors[:file_id].any? 
    assert content.errors[:file_type].any? 
    assert content.errors[:etd_id].any? 
  end
end
