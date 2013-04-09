class CopyrightStatementsController < ApplicationController
  # GET /copyright_statements
  # GET /copyright_statements.xml
  def index
    @copyright_statements = CopyrightStatement.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @copyright_statements) }
    end
  end

  # GET /copyright_statements/1
  # GET /copyright_statements/1.xml
  def show
    @copyright_statement = CopyrightStatement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @copyright_statement) }
    end
  end

  # GET /copyright_statements/new
  # GET /copyright_statements/new.xml
  def new
    @copyright_statement = CopyrightStatement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @copyright_statement) }
    end
  end

  # GET /copyright_statements/1/edit
  def edit
    @copyright_statement = CopyrightStatement.find(params[:id])
  end

  # POST /copyright_statements
  # POST /copyright_statements.xml
  def create
    @copyright_statement = CopyrightStatement.new(params[:copyright_statement])
    @copyright_statement.retired = @copyright_statement.retired == 1 ? true : false
    unless @copyright_statement.retired
      @copyright_statement.retired_at = nil
    end

    respond_to do |format|
      if @copyright_statement.save
        Provenance.create(person: current_person, action: "created", model: @copyright_statement)

        format.html { redirect_to(@copyright_statement, notice: 'CopyrightStatement was successfully created.') }
        format.xml  { render(xml: @copyright_statement, status: :created, location: @copyright_statement) }
      else
        format.html { render(action: "new") }
        format.xml  { render(xml: @copyright_statement.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /copyright_statements/1
  # PUT /copyright_statements/1.xml
  def update
    @copyright_statement = CopyrightStatement.find(params[:id])
    @copyright_statement.retired = @copyright_statement.retired == 1 ? true : false
    unless @copyright_statement.retired
      @copyright_statement.retired_at = nil
    end

    respond_to do |format|
      if @copyright_statement.update_attributes(params[:copyright_statement])
        Provenance.create(person: current_person, action: "updated", model: @copyright_statement)

        format.html { redirect_to(@copyright_statement, notice: 'CopyrightStatement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @copyright_statement.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /copyright_statements/1
  # DELETE /copyright_statements/1.xml
  def destroy
    @copyright_statement = CopyrightStatement.find(params[:id])
    Provenance.create(person: current_person, action: "destroyed", model: @copyright_statement)
    @copyright_statement.destroy

    respond_to do |format|
      format.html { redirect_to(copyright_statements_url) }
      format.xml  { head :ok }
    end
  end
end
