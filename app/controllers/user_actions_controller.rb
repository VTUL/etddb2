class UserActionsController < ApplicationController
  # GET /user_actions
  # GET /user_actions.xml
  def index
    @user_actions = UserAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @user_actions) }
    end
  end

  # GET /user_actions/1
  # GET /user_actions/1.xml
  def show
    @user_action = UserAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @user_action) }
    end
  end

  # GET /user_actions/new
  # GET /user_actions/new.xml
  def new
    @user_action = UserAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @user_action) }
    end
  end

  # GET /user_actions/1/edit
  def edit
    @user_action = UserAction.find(params[:id])
  end

  # POST /user_actions
  # POST /user_actions.xml
  def create
    @user_action = UserAction.new(params[:user_action])

    respond_to do |format|
      if @user_action.save
        format.html { redirect_to(@user_action, notice: 'User Action was successfully created.') }
        format.xml  { render(xml: @user_action, status: :created, location: @user_action) }
      else
        format.html { render(action: "new" }
        format.xml  { render(xml: @user_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_actions/1
  # PUT /user_actions/1.xml
  def update
    @user_action = UserAction.find(params[:id])

    respond_to do |format|
      if @user_action.update_attributes(params[:user_action])
        format.html { redirect_to(@user_action, notice: 'Action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @user_action.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /user_actions/1
  # DELETE /user_actions/1.xml
  def destroy
    @user_action = UserAction.find(params[:id])
    @user_action.destroy

    respond_to do |format|
      format.html { redirect_to(user_actions_url) }
      format.xml  { head :ok }
    end
  end
end
