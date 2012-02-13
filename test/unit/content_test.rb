#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # Even though page_count is in the "contents" table,
  # it is an attribute of the Document class
  # Please see the Document class for page_count assertion.
  test "should be invalid with empty attributes" do
    content = Content.new
    assert content.invalid?
    assert content.errors[:uploaded_file_name].any?
    assert content.errors[:uploaded_content_type].any?
    assert content.errors[:uploaded_file_size].any?
    assert content.errors[:availability_id].any?
  end
end

class DocumentTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    document = Document.new
    assert document.invalid?
    assert document.errors[:page_count].any?
  end
end

class AudioTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    audio = Audio.new
    assert audio.invalid?
    assert audio.errors[:duration].any?
  end
end

class PictureTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    picture = Picture.new
    assert picture.invalid?
    assert picture.errors[:dimensions].any?
  end
end

class VideoTest < ActiveSupport::TestCase
  test "should be invalid with empty attributes" do
    video = Video.new
    assert video.invalid?
    assert video.errors[:duration].any?
    assert video.errors[:dimensions].any?
  end
end
