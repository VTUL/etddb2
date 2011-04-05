require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  # Replace this with your real tests.
  test "should get new" do
    get :new
    assert_response :success
  end
  test "should create session" do
    assert_difference('Session.count') do
      post :create, :session => @update
    end
    assert_redirected_to session_path(assigns(:session))
  end
end
