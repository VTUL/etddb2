require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :home
    assert_response :success
    assert_not_nil assigns(:title)
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_not_nil assigns(:title)
  end

  test "should show contact" do
    get :contact
    assert_response :success
    assert_not_nil assigns(:title)
  end

  test "should get author help" do
    get :authorhelp
    assert_response :success
    assert_not_nil assigns(:title)
  end

  test "should get staff help" do
    get :staffhelp
    assert_response :success
    assert_not_nil assigns(:title)
  end

  test "should get dev" do
    get :dev
    assert_response :success
    assert_not_nil assigns(:title)
  end
end
