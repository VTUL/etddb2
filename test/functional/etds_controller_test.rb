require 'test_helper'

class EtdsControllerTest < ActionController::TestCase
  setup do
    @etd = etds(:one)
    @person = people(:one)
    sign_in(@person)
  end

  test "should get index" do
    get(:index)
    assert_response(:success)
    assert_not_nil(assigns(:etds))
  end

  test "should get new" do
    get(:new)
    assert_response(:success)
  end

  test "should create etd" do
    assert_difference('Etd.count') do
      @etd_attrs = @etd.attributes
      @etd_attrs[:department_ids] = {id_1: 1}
      post(:create, etd: @etd_attrs)
    end

    assert_redirected_to next_new_etd_path(assigns(:etd))
  end

  test "should not create etd" do
    assert_no_difference('Etd.count') do
      @etd_attrs = {}
      @etd_attrs[:department_ids] = {id_1: 1}
      post(:create, etd: @etd_attrs)
    end
    assert_select("div#error_explanation")
  end

  test "should get next_new" do
    get(:next_new, id: @etd.to_param)
    assert_response(:success)
    assert_not_nil(assigns(:etd))
  end

  test "should show etd" do
    get(:show, id: @etd.to_param)
    assert_response(:success)
    assert_not_nil(assigns(:etd))
  end

  test "should get edit" do
    get(:edit, id: @etd.to_param)
    assert_response(:success)
    assert_not_nil(assigns(:etd))
  end

  test "should update etd" do
    @etd_attrs = @etd.attributes
    @etd_attrs[:department_ids] = {id_1: 1}
    put(:update, id: @etd.to_param, etd: @etd_attrs)
    assert_redirected_to(etd_path(assigns(:etd)))
  end

  test "should not update etd" do
    @etd_attrs = {title: nil}
    @etd_attrs[:department_ids] = {id_1: 1}

    put(:update, id: @etd.to_param, etd: @etd_attrs)
    assert_select("div#error_explanation")
  end

  test "should be logged in for certain functionality." do
    sign_out(@person)

    get(:new)
    assert_redirected_to(login_path)

    get(:my_etds)
    assert_redirected_to(login_path)

    get(:edit, id: @etd.to_param)
    assert_redirected_to(login_path)

    delete(:destroy, id: @etd.to_param)
    assert_redirected_to(etds_path)
  end

  test "should only be able to edit and destroy your ETDs." do
    sign_out(@person)
    @person = people(:two)
    sign_in(@person)

    get(:edit, id: @etd.to_param)
    assert_redirected_to(etds_path)

    delete(:destroy, id: @etd.to_param)
    assert_redirected_to(etds_path)
  end

  test "should destroy etd" do
    assert_difference('Etd.count', -1) do
      delete(:destroy, id: @etd.to_param)
    end

    assert_redirected_to(controller: "etds", action: "index", notice: "ETD Deleted.")
  end

  test "should get my_etds" do
    get(:my_etds)
    assert_response(:success)
    assert_not_nil(assigns(:authors_etds))
  end

  test "should get add_contents" do
    post(:add_contents, id: @etd.to_param)
    assert_response(:success)
    assert_not_nil(assigns(:etd))
  end

  test "should add multiple contents (save_contents) to an ETD." do
    @content_a = Content.create(contents(:three).attributes)
    @content_b = Content.create(contents(:four).attributes)

    params = {contents_attributes: {new_1: @content_a.attributes, new_2: @content_b.attributes}}
    for c in @etd.contents do
      params[:contents_attributes]["#{c.id}"] = {id: c.id, _destroy: false}
    end
    
    assert_difference('@etd.contents.count', 2) do
      post(:save_contents, etd: params, origin: '/etds/add_contents/', id: @etd.id)
    end
  end  
  
  test "should delete multiple contents from an ETD." do
    params = {contents_attributes: {}}
    for c in @etd.contents do
      params[:contents_attributes]["#{c.id}"] = {id: c.id, _destroy: true}
    end

    assert_difference('@etd.contents.count', -(@etd.contents.count)) do
      post(:save_contents, etd: params, origin: '/etds/add_contents/', id: @etd.id)
    end
  end

  test "should submit the etd for review." do
    post(:submit, id: @etd.to_param)
    assert_response(:success)
  end
end
