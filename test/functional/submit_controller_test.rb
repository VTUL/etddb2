require 'test_helper'

class SubmitControllerTest < ActionController::TestCase
  setup do
  @etd = etds(:SungHeePark)
  @update = {
    :title	=> 'This test tile 2',
    :department => 'Mechanical Engineering',
    :dtype	=> 'thesis',
    :degree	=> 'MS',
    :bound	=> 'no'
  }
  end

  # Replace this with your real tests.

  test "should get index_etd" do
    get :index_etd
    assert_response :success
    assert_not_nil assigns(:etds)
  end

end
