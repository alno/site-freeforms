module SessionHandling
   
  def current_user_session
    return @current_user_session if @current_user_session # Если сесссия уже есть - выход
    
    if params[:email] && params[:password] # Автоматический логин по параметрам
      @current_user_session = UserSession.new( :email => params[:email], :password => params[:password], :remember_me => params[:remember_me] )
      @current_user_session = nil unless @current_user_session.save
      @current_user_session
    else
      @current_user_session = UserSession.find # Восстановление сессии
    end 
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      respond_to do |format|
        format.html do
          store_location
          flash[:error] = I18n.t('error.login_required')
          redirect_to root_url
          return false
        end
        format.text do
          render :text => ''
        end
        format.xml do        
          render :xml => ''
        end
      end
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