class PermissionsController < ApplicationController
  # GET /permissions
  # GET /permissions.xml
  def index
    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = UserAction.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /permissions/edit
  def edit
    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = UserAction.find(:all)

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # PUT /permissions/edit
  def update
    new_perms = Set[]
    for perm in params[:perms] do
      if perm[1] == "true"
        new_perms << perm[0]
      end
    end


    old_perms = Set[]
    for perm in Permission.all
      old_perms << "#{perm.role_id}_#{perm.digital_object_id}_#{perm.user_action_id}"
    end

    xor_perms = old_perms ^ new_perms

    new_count = 0
    del_count = 0
    for perm in xor_perms
      ids = perm.split("_")
      if new_perms.include? perm
        perm = Permission.create(role_id: ids[0], digital_object_id: ids[1], user_action_id: ids[2])
        Provenance.create(person: current_person, action: "created", model: perm)
        new_count += 1
      else
        # The loop here is only to prevent duplicate entries. It should actually execute in O(1) time, as there should only be one entry.
        for old_perm in Permission.where({role_id: ids[0], digital_object_id: ids[1], user_action_id: ids[2]})
          Provenance.create(person: current_person, action: "destroyed", model: old_perm)
          Permission.delete(old_perm.id)
          del_count += 1
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to(permissions_path, notice: "Successfully added #{new_count} permissions, and deleted #{del_count}.") }
    end
  end
end
