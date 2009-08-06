class MessagesController < ApplicationController
    
  before_filter :require_user
  
  def index
    @messages = current_user.messages.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html do
        @messages.each do |m|
          m.mark_read!
        end
        render :action => 'index'
      end
      format.xml  { render :xml => @messages }
    end
  end
  
  def today
    @messages = current_user.messages.today.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html do
        @messages.each do |m|
          m.mark_read!
        end
        render :action => 'index'
      end
      format.xml  { render :xml => @messages }
    end
  end
  
  def unread
    @messages = current_user.messages.unread.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html do
        @messages.each do |m|
          m.mark_read!
        end
        render :action => 'index'
      end
      format.xml  { render :xml => @messages }
    end
  end
  
  def export
    @filename = "export"
    @output_encoding = "CP1251"
    
    respond_to do |format|
      format.xml  { render :xml => @messages }
      format.xls  { @filename += '.xls' }
      format.csv  { @filename += '.csv' }
    end
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
      
end
