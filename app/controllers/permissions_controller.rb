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

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    @permission = Permission.find(params[:id])

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
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.xml
  def new
    @permission = Permission.new

    @permission.user_action_id = UserAction.new if @permission.user_action_id.nil?

    @person = Person.new
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
      format.html # new.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])

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

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    @permission = Permission.find(params[:id])

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
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to(@permission, :notice => 'Permission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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
