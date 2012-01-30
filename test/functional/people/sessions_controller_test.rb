require 'test_helper'

class People::SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session" do
    assert_difference('Session.count') do
      post :create, :person => {:pid=>"shpark", :password=>"123456789"}
    end
    assert_redirected_to session_path(assigns(:session2))
  end
end
