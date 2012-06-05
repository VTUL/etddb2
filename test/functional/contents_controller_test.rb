require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  def setup
    @content = contents(:one)
    @person = people(:one)
    sign_in @person
  end

  test "should redirect to login if not signed in." do
    sign_out @person
    get :index
    assert_response(:redirect)
    # TODO: Finish the sign in test.
  end

  test "should get index, if signed in." do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors_etds)
  end

  test "should get new" do
    post :new, etd_id: 1
    assert_response :success
  end

  test "should create content" do
    assert_difference('Content.count') do
      post :create, {content: @content.attributes, etd_id: 1}
    end

    assert_redirected_to content_path(assigns(:content))
  end

  test "should not create content" do
    assert_no_difference('Content.count') do
      post :create, {content: {}, etd_id: 1}
    end
    assert_select "div#error_explanation"
  end

  test "should show content" do
    get :show, id: @content.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content.to_param
    assert_response :success
  end

  test "should update content" do
    put :update, {id: @content.to_param, content: @content.attributes}
    assert_redirected_to content_path(assigns(:content))
  end

  test "should not update content" do
    put :update, {id: @content.to_param, content: @content.attributes.merge(bound: nil)}
    assert_select "div#error_explanation"
  end

  test "should destroy content" do
    assert_difference('Content.count', -1) do
      delete :destroy, id: @content.to_param
    end

    assert_redirected_to contents_path
  end
end
