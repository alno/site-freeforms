class AccountsController < ApplicationController
  
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    redirect_to root_url + '#register'
  end
  
  def create
    current_user_session.destroy if current_user_session
    
    @user = User.new(params[:account])
    @user.activated_at = Time.now
    
    if @user.save
      #@user.deliver_activation_instructions!
      @user_session = UserSession.create @user
      
      if params[:form]
        @form = @user.forms.first
        @form.assign params[:form]
        @form.save!
      end
      
      flash[:notice] = I18n.t('notice.account_registered')
      
      redirect_to messages_url
    else      
      @form = Form.new
      @form.assign params[:form] if params[:form]
      
      @user_session = UserSession.new
      
      render :template => 'root/register'
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    
    if @user.update_attributes(params[:account])
      flash[:notice] = I18n.t('notice.account_updated')
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy    
  end
  
end
