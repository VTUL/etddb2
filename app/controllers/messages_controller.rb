class MessagesController < ApplicationController
  before_filter :get_box
  def index
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    if @message = Message.find(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(current_person)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
      return
      end
    end
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    if params[:receiver].present?
      @recipient = Person.find(params[:receiver])
      return if @recipient.nil?
      @recipient = nil if @recipient==current_person
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.xml
  def create
    @recipients = []
    if params[:_recipients].present?
      params[:_recipients] = params[:_recipients].split(',')
      params[:_recipients].each do |recp_id|
        recp = Person.find(recp_id)
        next if recp.nil?
        @recipients << recp
      end
    end
    @receipt = current_person.send_message(@recipients, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success]= t('mailboxer.sent')
      redirect_to conversation_path(@conversation, :box => :sentbox)
    else
      render :action => :new
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
  end

  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
    return
    end
    @box = params[:box]
  end

end
