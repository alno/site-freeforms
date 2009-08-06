require 'iconv'

class FormsController < ApplicationController
  
  layout 'default', :except => [ :code ]
    
  before_filter :require_user, :except => [ :code ]
  
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
    @form = Form.find(params[:id])
  end
  
  def new
    @form = Form.new
  end
  
  def show
    @form = current_user.forms.find(params[:id])
  end
  
  def clone
    @form = current_user.forms.find(params[:id])
  end
  
  def edit
    @form = current_user.forms.find(params[:id])
  end
  
  def messages
    @form = current_user.forms.find( params[:id] )
    @messages = @form.messages.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html do
        @messages.each do |m|
          m.mark_read!
        end
      end
      format.text
      format.xml  { render :xml => @messages }
    end
  end
  
  def unread
    @form = current_user.forms.find( params[:id] )
    @messages = @form.messages.unread.paginate( :all, :page => params[:page], :order => 'created_at DESC' )

    respond_to do |format|
      format.html do
        @messages.each do |m|
          m.mark_read!
        end
        render :action => 'messages'
      end
      format.text { render :action => 'messages' }
      format.xml  { render :xml => @messages }
    end
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
    @form = current_user.forms.find(params[:id])
    @form.assign params[:form]
    
    if @form.save
      redirect_to form_path( @form )
    else
      render :action => :edit
    end
  end
  
  def preview
    @form = current_user.forms.build
    @form.id = 0
    @form.assign params[:form]
    
    @css = render_to_string :action => 'code.css', :layout => false
    
    render :layout => false
  end
  
  def destroy
    @form = current_user.forms.find(params[:id])
    @form.destroy
    
    redirect_to account_path
  end

end
