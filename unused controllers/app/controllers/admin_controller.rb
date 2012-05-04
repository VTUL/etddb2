class AdminController < ApplicationController
  def index
    add_user
  end

  def add_user
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)
    @roles=Role.find(:all)

    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end

    respond_to do |format|
      format.html #{redirect_to(:controller=>"people", :action=>"new")}
      #format.html { redirect_to(:controller=>"submit", :action => "new_etd") }
    end
  end

  def delete_user
  end

  def show_user
  end

  def edit_edit
  end

  def reportEtdStatistics
  end

  def reportUsage
  end

  def import
  end

  def export
  end

  # GET /admin/add_role
  # GET /admin/add_role.xml
  def add_role
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)
    @roles=Role.find(:all)

    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end


    @role = Role.new

    respond_to do |format|
      format.html #{redirect_to(:controller=>"roles", :action=>"new")}
      format.xml  { render :xml => @role }
      #format.html { redirect_to(:controller=>"submit", :action => "new_etd") }
    end
  end

  def delete_role
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
 
  def show_role
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)

    @role = Role.find(params[:id])

    respond_to do |format|
      format.html #{redirect_to(:controller=>"roles", :action=>"show",:id=>"#{params[:id]}")}
      #format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  def index_role
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)
    @roles=Role.find(:all)

    respond_to do |format|
      format.html #{redirect_to(:controller=>"roles", :action=>"show",:id=>"#{params[:id]}")}
      #format.html # show.html.erb
      format.xml  { render :xml => @role }
    end

  end

  def edit_role
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)

    @role = Role.find(params[:id])
  end


  def edit_permission
    @permission = Permission.find(:first)

    #@permission = Permission.find(:all)
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)
    @roles=Role.find(:all)
  
    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end


  end


  def add_permission
    @permission = Permission.new
    @permission.user_action_id = UserAction.new if @permission.user_action_id.nil?

    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)

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
  end

  def create_permission
    @array_permission = params[:permission]
    
    
    @role_id = 0
    @action_ids = params[:permission][:action0][:do1]
    @digital_object_id = params[:permission][:action0][:do1]
 
    #
    for actionid in @action_ids
      @permission = Permission.new
      @permission.action_id = actionid
      begin
        @permission.save
      rescue   
 
      end
    end

    respond_to do |format|
    #  if @permission.save
        #format.html { redirect_to(@permission, :notice => 'Permission was successfully created.') }
        format.html { redirect_to(:controller=>:admin,:action=>:show_permission)} #@permission, :notice => 'Permission was successfully created.') }
        format.xml  { render :xml => @permission, :status => :created, :location => @permission }
   #   else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
   #   end
    end
  end


  def show_permission
    @permission = Permission.new
    @permission.action_id = Action.new if @permission.action_id.nil?

    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)

    @roles = Role.find(:all)
    @digital_objects = DigitalObject.find(:all)
    @actions = Action.find(:all)
  

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

  end

  def delete_permission
  end

  def index_permission
    @person = Person.new
    @person.roles << Role.find(:all,:conditions=>"name='admin'")
    @ability = Ability.new(@person)
    @roles=Role.find(:all)

    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end
  end
  def admin_main


  end
end
