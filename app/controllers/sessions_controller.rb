class SessionsController < ApplicationController
  
  before_filter :require_user, :only => :destroy
    
  def new
    redirect_to root_url + '#login'
  end
  
  def create
    @user_session = UserSession.new(params[:session])
    
    if @user_session.save
      flash[:notice] = I18n.t('notice.login_successful')
      redirect_to messages_url
    else
      flash[:error] = I18n.t('error.wrong_login_or_password')
      redirect_to root_url + '#login'
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t('notice.logout_successful')
    redirect_back_or_default root_url + '#login'
  end

end
