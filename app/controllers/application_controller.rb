class ApplicationController < ActionController::Base
  
  include ExceptionNotifiable
  include SessionHandling
    
  layout 'default'
  
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user_session, :current_user

end
