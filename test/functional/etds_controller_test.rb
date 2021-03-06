require 'test_helper'

class EtdsControllerTest < ActionController::TestCase
  setup do
    @etd = Etd.first
    @person = Person.first
    sign_in(@person) 
  end

  test "should get index" do
    sign_out(@person)
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

    assert_redirected_to(next_new_etd_path(assigns(:etd)))
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
    sign_out(@person)
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

  test "should only be able to edit and destroy your ETDs." do
    sign_out(@person)
    @person = Person.last
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

  test "should get add_contents" do
    post(:add_contents, id: @etd.to_param)
    assert_response(:success)
    assert_not_nil(assigns(:etd))
  end

  test "should add multiple contents (save_contents) to an ETD." do
    @content_a = Content.last
    @content_b = Content.first

    params = {contents_attributes: {new_1: @content_a.attributes.merge({id: nil}), new_2: @content_b.attributes.merge({id: nil})}}
    for c in @etd.contents do
      params[:contents_attributes]["#{c.id}"] = {id: c.id, _destroy: false}
    end
    
    assert_difference('@etd.contents.count', 2) do
      post(:save_contents, etd: params, origin: '/etds/add_contents/', id: @etd.id)
    end
  end  

  test "should correct the origin param." do
    params = {contents_attributes: {}}
    for c in @etd.contents do
      params[:contents_attributes]["#{c.id}"] = {id: c.id, _destroy: false}
    end

    post(:save_contents, etd: params, origin: '/bad/path/', id: @etd.id)
    assert_redirected_to(controller: 'etds', action: 'add_contents')
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

  test "Switching the ETD to Mixed should not update it's content." do
    @etd_attrs = @etd.attributes
    @etd_attrs[:department_ids] = {id_1: 1}

    assert_no_difference '@etd.contents.first.availability_id' do
      assert_no_difference '@etd.contents.last.availability_id' do
        @etd_attrs[:availability_id] = Availability.where(name: "Mixed").first.id
        put(:update, id: @etd.to_param, etd: @etd_attrs)
      end
    end
  end

  test "Changing to anything other than Mixed should update content." do
    @etd_attrs = @etd.attributes
    @etd_attrs[:department_ids] = {id_1: 1}

    new_avail = Availability.where(name: "Withheld").first.id
    assert_not_equal(@etd.contents.first.availability_id, new_avail)
    assert_not_equal(@etd.contents.last.availability_id, new_avail)

    @etd_attrs[:availability_id] = new_avail
    put(:update, id: @etd.to_param, etd: @etd_attrs)
    assert_equal(@etd.contents.first.availability_id, new_avail)
    assert_equal(@etd.contents.last.availability_id, new_avail)
  end

  test "should not be able to vote on an ETD." do
    # Not-signed-in tested elsewhere.

    # Shouldn't vote on an unsubmitted ETD.
    post(:vote, id: @etd.id, vote: 'true')
    assert_redirected_to(person_path(@person), notice: "That ETD is not ready to be voted on.")

    # Shouldn't vote if you aren't a committee member.
    @etd.status = "Submitted"
    @etd.save
    post(:vote, id: @etd.id, vote: 'true')
    assert_redirected_to(person_path(@person), notice: "You cannot vote on that ETD.")
  end

  test "should be able to vote on an submitted ETD." do
    @etd.status = "Submitted"
    @etd.save

    # Sign in an actual committee member.
    sign_out(@person)
    @person = Person.last
    @etd.people_roles << PeopleRole.new(person_id: @person.id, role_id: Role.where(group: "Collaborators").first.id)
    sign_in(@person)

    # Should vote on a submitted ETD.
    post(:vote, id: @etd.id, vote: 'not true')
    assert_response(:success)
    assert(!@etd.people_roles.where(person_id: @person.id).last.vote)
    post(:vote, id: @etd.id, vote: 'true')
    assert_response(:success)
    assert(@etd.people_roles.where(person_id: @person.id).last.vote)
    assert(!ActionMailer::Base.deliveries.empty?)
  end

  test "should unsubmit an ETD, if appropriate." do
    # ETD not submitted
    post(:unsubmit, id: @etd.id)
    assert_redirected_to(person_path(@person), notice: "You cannot unsubmit an ETD that hasn't been submitted.")

    # Non-Grad School person.
    @etd.status = "Submitted"
    @etd.save
    post(:unsubmit, id: @etd.id)
    assert_redirected_to(person_path(@person), notice: "You cannot unsubmit ETDs.")

    # Success!
    @person.people_roles << PeopleRole.new(role_id: Role.where(group: "Graduate School").first.id)
    post(:unsubmit, id: @etd.id)
    assert_redirected_to(etd_path(@etd), notice: "Successfully unsubmitted this ETD.")
  end
end
