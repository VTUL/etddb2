require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = Message.first
    @person = Person.first
    sign_in(@person)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { msg: @message.msg, read: @message.read, recipient_id: @message.recipient_id, sender_id: @message.sender_id }
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should not create a message" do
    assert_no_difference('Message.count') do
      post :create, message: { msg: @message.msg }
    end

    assert_response :success
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    put :update, id: @message, message: { msg: @message.msg, read: @message.read, recipient_id: @message.recipient_id, sender_id: @message.sender_id }
    assert_redirected_to message_path(assigns(:message))
  end

  test "should not update message" do
    put :update, id: @message, message: { msg: @message.msg, read: @message.read, recipient_id: @message.recipient_id, sender_id: nil }
    assert_response :success
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
