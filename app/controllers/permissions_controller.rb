class PermissionsController < ApplicationController
  # GET /permissions
  # GET /permissions.xml
  def index
    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = UserAction.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @permissions }
    end
  end

  # GET /permissions/edit_all
  def edit_all
    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = UserAction.find(:all)

    respond_to do |format|
      format.html # edit_all.html.erb
    end
  end

  # POST /permissions/edit_all
  def update_all
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
        Permission.create!(:role_id => ids[0], :digital_object_id => ids[1], :user_action_id => ids[2])
        new_count += 1
      else
        # The loop here is only to prevent duplicate entries. It should actually execute in O(1) time, as there should only be one entry.
        for old_perm in Permission.where({:role_id => ids[0], :digital_object_id => ids[1], :user_action_id => ids[2]})
          Permission.delete(old_perm.id)
          del_count += 1
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to(permissions_url, :notice => "Successfully added #{new_count} permissions, and deleted #{del_count}.") }
    end
  end

  # POST /permissions
  # POST /permissions.xml
  def create
    @permission = Permission.new(params[:permission])

        #@permission.user_action_id = UserAction.new if @permission.user_action_id.nil?

    #@person = Person.new
    #@person.roles << Role.find(:all,:conditions=>"name='admin'") unless Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(current_person)

    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = UserAction.find(:all)


    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end

    @array_digital_objects = []
    for digital_object  in @digital_objects
      @array_digital_objects << digital_object.name
    end

    @array_actions = []
    for action  in @actions
      @array_actions << action.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @permissions }
    end

    respond_to do |format|
      if @permission.save
        format.html { redirect_to(@permission, :notice => 'Permission was successfully created.') }
        format.xml  { render :xml => @permission, :status => :created, :location => @permission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(permissions_url) }
      format.xml  { head :ok }
    end
  end
end
