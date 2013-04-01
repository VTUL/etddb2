class PrivacyStatementsController < ApplicationController
  # GET /privacy_statements
  # GET /privacy_statements.json
  def index
    @per_page = Pagination_Helper.sanitize_per_page(params[:per_page])
    @privacy_statements = PrivacyStatement.paginate(:page => params[:page], per_page: @per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render(json: @privacy_statements) }
    end
  end

  # GET /privacy_statements/1
  # GET /privacy_statements/1.json
  def show
    @privacy_statement = PrivacyStatement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render(json: @privacy_statement) }
    end
  end

  # GET /privacy_statements/new
  # GET /privacy_statements/new.json
  def new
    @privacy_statement = PrivacyStatement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render(json: @privacy_statement) }
    end
  end

  # GET /privacy_statements/1/edit
  def edit
    @privacy_statement = PrivacyStatement.find(params[:id])
  end

  # POST /privacy_statements
  # POST /privacy_statements.json
  def create
    @privacy_statement = PrivacyStatement.new(params[:privacy_statement])

    respond_to do |format|
      if @privacy_statement.save
        Provenance.create(person: current_person, action: "created", model: @privacy_statement)

        format.html { redirect_to(@privacy_statement, notice: 'Privacy statement was successfully created.') }
        format.json { render(json: @privacy_statement, status: :created, location: @privacy_statement) }
      else
        format.html { render(action: "new") }
        format.json { render(json: @privacy_statement.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /privacy_statements/1
  # PUT /privacy_statements/1.json
  def update
    @privacy_statement = PrivacyStatement.find(params[:id])

    respond_to do |format|
      if @privacy_statement.update_attributes(params[:privacy_statement])
        Provenance.create(person: current_person, action: "updated", model: @privacy_statement)

        format.html { redirect_to(@privacy_statement, notice: 'Privacy statement was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @privacy_statement.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /privacy_statements/1
  # DELETE /privacy_statements/1.json
  def destroy
    @privacy_statement = PrivacyStatement.find(params[:id])
    Provenance.create(person: current_person, action: "destroyed", model: @privacy_statement)
    @privacy_statement.destroy

    respond_to do |format|
      format.html { redirect_to(privacy_statements_url) }
      format.json { head :ok }
    end
  end
end
