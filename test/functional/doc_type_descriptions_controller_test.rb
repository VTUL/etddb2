require 'test_helper'

class DocTypeDescriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doc_type_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doc_type_description" do
    assert_difference('DocTypeDescription.count') do
      post :create, :doc_type_description => {:name=>"dissertation" }
    end

    assert_redirected_to doc_type_description_path(assigns(:doc_type_description))
  end

  test "should show doc_type_description" do
    get :show, :id => doc_type_descriptions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => doc_type_descriptions(:one).to_param
    assert_response :success
  end

  test "should update doc_type_description" do
    put :update, :id => doc_type_descriptions(:one).to_param, :doc_type_description => { }
    assert_redirected_to doc_type_description_path(assigns(:doc_type_description))
  end

  test "should destroy doc_type_description" do
    assert_difference('DocTypeDescription.count', -1) do
      delete :destroy, :id => doc_type_descriptions(:one).to_param
    end

    assert_redirected_to doc_type_descriptions_path
  end
end
