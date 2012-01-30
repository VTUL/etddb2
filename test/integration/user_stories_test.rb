require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

 test "login and new etd site" do
    # login via https
    #https!
    get "/login"
    assert_response :success

    post_via_redirect "/login", {:pid => people(:Collin).pid, :password => people(:Collin).suffix}
    assert_equal '/page#home', path
    #assert_equal 'Welcome shpark!', flash[:notice]

    https!(false)
    get "/etds/"
    assert_response :success
    assert assigns(:etds)
  end
end
