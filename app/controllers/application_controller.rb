class ApplicationController < ActionController::Base
  
  include SessionHandling
    
  layout 'default'
    
  helper :all
  helper_method :current_user_session, :current_user

end
