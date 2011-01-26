require 'iconv'

class FormsController < ApplicationController

  layout 'default', :except => [ :code ]

  before_filter :require_user, :except => [ :code ]
  before_filter :load_user_form, :except => [ :index, :code, :new, :create ]

  cache_sweeper FormCodeSweeper, :only => [ :update, :destroy ]

  caches_page :code

  def index
    @forms = current_user.forms.paginate( :all, :page => params[:page], :order => 'forms.created_at DESC' )

    respond_to do |format|
      format.html
      format.text
      format.xml  { render :xml => @forms }
    end
  end

  def code
    @form = Form.find params[:id]
  end

  def clone
    render :action => 'new'
  end

  def new
    @form = Form.new
  end

  def messages
    respond_with_messages( @form.messages, "all_messages_#{@form.id}" )
  end

  def unread
    respond_with_messages( @form.messages.unread, "unread_messages_#{@form.id}" )
  end

  def today
    respond_with_messages( @form.messages.today, "today_messages_#{@form.id}" )
  end

  def create
    @form = current_user.forms.build
    @form.assign params[:form]

    if @form.save
      redirect_to form_path( @form ) + '#form-code'
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

  def respond_with_messages( msgs, fname )
    respond_to do |format|

      format.html do
        @messages = msgs.paginate( :all, :page => params[:page], :order => 'messages.created_at DESC' )

        render :action => 'messages'
      end

      format.text do
        @messages = params[:min_id] ? msgs.find(:all,:conditions => [ 'id >= ?', params[:min_id] ]) : msgs

        render :action => 'messages'
      end if params[:format] == 'txt'

      format.xml do
        render :xml => msgs
      end if params[:format] == 'xml'

      format.xls do
        @messages = msgs
        @output_encoding = "CP1251"
        @filename = fname + '.xls'

        render :action => 'messages'
      end if params[:format] == 'xls'

      format.csv do
        @messages = msgs
        @output_encoding = "CP1251"
        @filename = fname + '.csv'

        render :action => 'messages'
      end if params[:format] == 'csv'

    end
  end

end
