require 'test_helper'

class DocumentTypesControllerTest < ActionController::TestCase
  setup do
    @document_type = DocumentType.first
    @person = Person.first
    sign_in(@person) 
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_type" do
    assert_difference('DocumentType.count') do
      post :create, document_type: @document_type.attributes
    end

    assert_redirected_to document_type_path(assigns(:document_type))
  end

  test "should not create document_type" do
    assert_no_difference('DocumentType.count') do
      post :create, document_type: {}
    end
    assert_select "div#error_explanation"
  end

  test "should show document_type" do
    get :show, id: @document_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_type.to_param
    assert_response :success
  end

  test "should update document_type" do
    put :update, id: @document_type.to_param, document_type: @document_type.attributes
    assert_redirected_to document_type_path(assigns(:document_type))
  end

  test "should not update document_type" do
    put :update, id: @document_type.to_param, document_type: {name: nil}
    assert_select "div#error_explanation"
  end

  test "should destroy document_type" do
    assert_difference('DocumentType.count', -1) do
      delete :destroy, id: @document_type.to_param
    end

    assert_redirected_to document_types_path
  end
end
