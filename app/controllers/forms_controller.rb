require 'iconv'

class FormsController < ApplicationController
  
  layout 'default', :except => [ :code ]
    
  before_filter :require_user, :except => [ :code ]
  before_filter :load_user_form, :except => [ :index, :code, :new, :create ]
  
  cache_sweeper FormCodeSweeper, :only => [ :update, :destroy ]
  
  caches_page :code
  
  def index
    @forms = current_user.forms.paginate( :all, :page => params[:page], :order => 'created_at DESC' )
    
    respond_to do |format|
      format.html
      format.text
      format.xml  { render :xml => @forms }
    end
  end
  
  def code
    @form = Form.find params[:id]
  end
  
  def new
    @form = Form.new
  end
    
  def messages
    render_messages( @form.messages )
  end
  
  def unread
    render_messages( @form.messages.unread )
  end
  
  def create
    @form = current_user.forms.build
    @form.assign params[:form]
    
    if @form.save
      redirect_to form_path( @form )
    else
      render :action => :new
    end
  end
  
  def update
    @form.assign params[:form]
    
    if @form.save
      redirect_to form_path( @form )
    else
      render :action => :edit
    end
  end
    
  def destroy
    @form.destroy
    
    redirect_to account_path
  end
  
  protected
  
  # Загрузить форму пользователя по заданному идентификатору
  def load_user_form
    @form = current_user.forms.find params[:id]
  end
  
  def render_messages( msgs )
    respond_to do |format|
      format.html do
        @messages = msgs.paginate( :all, :page => params[:page], :order => 'created_at DESC' )
        
        render :action => 'messages'
      end
      format.text do
        if params[:min_id]          
          @messages = msgs.find(:all,:conditions => [ 'id >= ?', params[:min_id] ])
        else          
          @messages = msgs
        end
        
        render :action => 'messages'
      end
      format.xml do        
        render :xml => (@messages = msgs)
      end
    end
  end

end
