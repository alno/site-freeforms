class MessagesController < ApplicationController
    
  before_filter :require_user
  
  def index
    respond_with_messages( current_user.messages, "all_messages" )
  end
  
  def today
    respond_with_messages( current_user.messages.today, "today_messages" )
  end
  
  def unread    
    respond_with_messages( current_user.messages.unread, "unread_messages" )
  end

  def show
    @message = current_user.messages.find(params[:id])    
    @message.mark_read!
    
    @form = @message.form

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.xml  { head :ok }
    end
  end
  
  protected
    
  def respond_with_messages( msgs, fname )
    respond_to do |format|
      
      format.html do
        @messages = msgs.paginate( :all, :page => params[:page], :order => 'created_at DESC' )
        
        render :action => 'index'
      end
      
      format.xml do
        render :xml => msgs
      end if params[:format] == 'xml'
      
      format.xls do
        @messages = msgs
        @output_encoding = "CP1251"
        @filename = fname + '.xls'
        
        render :action => 'index'
      end if params[:format] == 'xls'
      
      format.csv do
        @messages = msgs
        @output_encoding = "CP1251"
        @filename = fname + '.csv'
        
        render :action => 'index'
      end if params[:format] == 'csv'
      
    end
  end
      
end
