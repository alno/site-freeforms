class ApplicationController < ActionController::Base
  
  include ExceptionNotifiable
    
  layout 'default'
  
  filter_parameter_logging :password, :password_confirmation
  
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  
  protected
  
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash[:error] = I18n.t('error.login_required')
      redirect_to root_url
      return false
    end
  end
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    
    unless @user
      flash[:error] = I18n.t('error.no_user_found')
      redirect_to root_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
