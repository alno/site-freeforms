class MessagesController < ApplicationController
  
  layout 'default'
  
  before_filter :require_user
  
  # GET /messages
  # GET /messages.xml
  def index
    @messages = current_user.messages.find(:all,:order => 'created_at DESC')

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @messages }
    end
  end
  
  # GET /messages/unread
  # GET /messages/unread.xml
  def unread
    @messages = current_user.messages.unread.find(:all,:order => 'created_at DESC')

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = current_user.messages.find(params[:id])
    
    unless @message.read_at # Отмечаем сообщение, как прочитанное
       @message.read_at = Time.now
       @message.save!
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  # GET /messages/1/edit
  def edit
    @message = current_user.messages.find(params[:id])
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = current_user.messages.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
