class ConversationsController < ApplicationController
  before_filter :get_box
  before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]
  def index
    if @box.eql? "inbox"
      @conversations = current_person.mailbox.inbox
    elsif @box.eql? "sentbox"
      @conversations = current_person.mailbox.sentbox
    else
      @conversations = current_person.mailbox.trash
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = current_person.mailbox.receipts_for(@conversation).trash
    else
      @receipts = current_person.mailbox.receipts_for(@conversation).not_trash
    end
    render :action => :show
    @receipts.mark_as_read
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    if params[:untrash].present?
    @conversation.untrash(current_person)
    end

    if params[:reply_all].present?
      last_receipt = current_person.mailbox.receipts_for(@conversation).last
      @receipt = current_person.reply_to_all(last_receipt, params[:body])
    end

    if @box.eql? 'trash'
      @receipts = current_person.mailbox.receipts_for(@conversation).trash
    else
      @receipts = current_person.mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read
  end

  def destroy
    @conversation.move_to_trash(current_person)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
	    else
          redirect_to conversations_path(:box => @box,:page => params[:page])
	    end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box,:page => params[:page])}';"
	    else
          render 'conversations/destroy'
	    end
      }
    end
  end

  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
    return
    end
    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(current_person)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

end
