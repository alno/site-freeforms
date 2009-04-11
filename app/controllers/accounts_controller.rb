class AccountsController < ApplicationController
  
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    redirect_to root_url + '#register'
  end
  
  def create
    @user = User.new(params[:account])
    
    if @user.save
      @user.deliver_activation_instructions!
      
      flash[:notice] = I18n.t('notice.account_registered')
      redirect_back_or_default root_url
    else
      @user_session = UserSession.new
      @hash = '\'#register\''
      render :template => 'root/index'
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
