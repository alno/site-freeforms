class MessagesController < ApplicationController
    
  before_filter :require_user
  
  # GET /messages
  # GET /messages.xml
  def index
    @messages = current_user.messages.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @messages }
      format.xls
    end
  end
  
  def today
    @messages = current_user.messages.today.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @messages }
    end
  end
  
  # GET /messages/unread
  # GET /messages/unread.xml
  def unread
    @messages = current_user.messages.unread.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = current_user.messages.find(params[:id])
    @form = @message.form
    
    unless @message.read_at # Отмечаем сообщение, как прочитанное
       @message.read_at = Time.now
       @message.save!
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.xml  { head :ok }
    end
  end
    
end
