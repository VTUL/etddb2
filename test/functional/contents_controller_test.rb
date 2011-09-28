require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
# called before every single test
  def setup
    @content = contents(:one)
  end
  def teardown
    # as we are re-initializing @post before every test
    # setting it to nil here is not essential but I hope
    # you understand how you can use the teardown method
    @content = nil
  end 
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content" do
    assert_difference('Content.count') do
      #post :create, :content => contents(:one).to_param
      post :create, :content => {:uploaded_file_name=>"test.pdf", :uploaded_content_type => "pdf", 
                  :uploaded_file_size => 123, :availability => "unrestricted", :bound=>"no" }
    end

    assert_redirected_to content_path(assigns(:content))
  end

  test "should show content" do
    get :show, :id => contents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => contents(:one).to_param
    assert_response :success
  end

  test "should update content" do
    put :update, :id => contents(:one).to_param, :content => { }
    assert_redirected_to content_path(assigns(:content))
  end

  test "should destroy content" do
    assert_difference('Content.count', -1) do
      delete :destroy, :id => @content.id, :file_name => @content.uploaded_file_name
    end

    assert_redirected_to contents_path
  end
end
