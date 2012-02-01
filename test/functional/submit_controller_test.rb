require 'test_helper'

class SubmitControllerTest < ActionController::TestCase
  setup do
  @etd = etds(:one)
  @update = {:title => 'This test tile 2', :degree_id => 1, :document_type_id => 2, :bound => false}
  end

  # Replace this with your real tests.

  test "should get index_etd" do
    get :index_etd
    assert_response :success
    assert_not_nil assigns(:etds)
  end

end
