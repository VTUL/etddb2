require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  def setup
    @content = Content.first
    @person = Person.first
    sign_in(@person)
  end

  test "should get index, if signed in." do
    get(:index)
    assert_response(:success)
    assert_not_nil(assigns(:authors_etds))
  end

  test "should get new" do
    post(:new, etd_id: 1)
    assert_response(:success)
  end

  test "should create content" do
    assert_difference('Content.count') do
      post(:create, {content: @content.attributes, etd_id: 1})
    end

    assert_redirected_to(content_path(assigns(:content)))
  end

  test "should not create content" do
    assert_no_difference('Content.count') do
      post(:create, {content: {}, etd_id: 1})
    end
    assert_select("div#error_explanation")
  end

  test "should show content" do
    get(:show, id: @content.to_param)
    assert_response(:success)
  end

  test "should get edit" do
    get(:edit, id: @content.to_param)
    assert_response(:success)
  end

  test "should update content" do
    put(:update, {id: @content.to_param, content: @content.attributes})
    assert_redirected_to(content_path(assigns(:content)))
  end

  test "should not update content" do
    put(:update, {id: @content.to_param, content: @content.attributes.merge({bound: nil})})
    assert_select("div#error_explanation")
  end

  test "should destroy content" do
    assert_difference('Content.count', -1) do
      delete(:destroy, id: @content.to_param)
    end

    assert_redirected_to(contents_path)
  end

  test "should change the ETD's availability if appropriate." do
    @etd = Etd.first
    mixed_avail = Availability.where(name: "Mixed").first.id
    withheld_avail = Availability.where(name: "Withheld").first.id
    available_avail = Availability.where(name: "Available").first.id

    # Should change from the default to mixed by updating a piece of content.
    assert_not_equal(@etd.availability_id, mixed_avail)
    c = @etd.contents.first
    post(:update, {id: c.to_param, content: c.attributes.merge({availability_id: withheld_avail})})
    # Reload the ETD from the DB to get the changes. (You don't want to debug this.)
    @etd = Etd.find(@etd.id)
    assert_equal(@etd.availability_id, mixed_avail)

    # Should change to Withheld by updating all the content.
    for c in @etd.contents do
      post(:update, {id: c.to_param, content: c.attributes.merge({availability_id: withheld_avail})})
    end
    @etd = Etd.find(@etd.id)
    assert_equal(@etd.availability_id, withheld_avail)

    # Should not change the avail when creating content with the ETD's avail.
    @contents = Content.last
    post(:create, {content: @content.attributes.merge({availability_id: withheld_avail}), etd_id: @etd.id})
    @etd = Etd.find(@etd.id)
    assert_equal(@etd.availability_id, withheld_avail)

    # Should change to Mixed with new content of a different avail.
    #@contents = contents(:four)
    post(:create, {content: @content.attributes.merge({availability_id: available_avail}), etd_id: @etd.id})
    @etd = Etd.find(@etd.id)
    assert_equal(@etd.availability_id, mixed_avail)
  end
end
