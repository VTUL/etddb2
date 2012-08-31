class ConversationsController < ApplicationController
  # GET /conversations
  # GET /conversations.json
  def mailbox
    @convs = []
    @box = params[:box]
    case @box
    when 'outbox'
      @convs = current_person.sent_messages.order('updated_at DESC').map { |m| m.conversation unless m.conversation.archived_by?(current_person) } .uniq
    when 'all'
      @convs = current_person.conversations.order('updated_at DESC')
    when 'archived'
      @convs = current_person.conversations.order('updated_at DESC').map { |c| c if c.archived_by?(current_person) } .uniq
    when 'unread'
      @convs = current_person.conversations.order('updated_at DESC').map { |c| c unless c.read_by?(current_person) or c.archived_by?(current_person) } .uniq
    when 'all unread'
      @convs = current_person.conversations.order('updated_at DESC').map { |c| c unless c.read_by?(current_person) } .uniq
    else
      # Inbox by default.
      @convs = current_person.conversations.order('updated_at DESC').map { |c| c unless c.archived_by?(current_person) } .uniq
    end

    respond_to do |format|
      format.html # mailbox.html.erb
      format.json { render json: @convs }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conv = Conversation.find(params[:id])
    @messages = @conv.messages.order('created_at ASC')

    @conv.set_read(current_person)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conv }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conv = Conversation.new
    @conv.messages << Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conv }
    end
  end

  # POST /conversations/new
  # POST /conversations/new.json
  def create
    @conv = Conversation.new(params[:conversation])

    @conv.participant_ids = [current_person.id] | params[:conversation][:participant_ids].split(',')

    respond_to do |format|
      if @conv.save
        format.html { redirect_to @conv, notice: 'Conversation was successfully created.' }
        format.json { render json: @conv, status: :created, location: @conv }
      else
        format.html { render action: "new" }
        format.json { render json: @conv.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /conversations/reply/1
  def reply
    @message = Message.new

    respond_to do |format|
      format.html # reply.html.erb
      format.json { render json: @message }
    end
  end

  # POST /conversations/reply/1
  # POST /conversations/reply.json
  def send_reply
    @message = Message.new(params[:message])
    @message.conversation_id = params[:id]

    respond_to do |format|
      if @message.save
        format.html { redirect_to Conversation.find(params[:id]), notice: 'Message Sent.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "reply" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /conversations/read/1
  def read
    @conv = Conversation.find(params[:id])
    @conv.set_read(current_person)
    @conv.save

    redirect_to conversations_path
  end

  # GET /conversations/unread/1
  def unread
    @conv = Conversation.find(params[:id])
    @conv.set_read(current_person, false)
    @conv.save

    redirect_to conversations_path
  end

  # GET /conversations/archive/1
  def archive
    @conv = Conversation.find(params[:id])
    @conv.set_archived(current_person)
    @conv.save

    redirect_to conversations_path
  end

  # GET /conversations/unarchive/1
  def unarchive
    @conv = Conversation.find(params[:id])
    @conv.set_archived(current_person, false)
    @conv.save

    redirect_to conversations_path
  end
end
