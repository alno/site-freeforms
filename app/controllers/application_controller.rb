class ApplicationController < ActionController::Base

  include SessionHandling

  layout 'default'

  helper :all
  helper_method :current_user_session, :current_user

  before_filter :set_ru_locale

  def set_ru_locale
    I18n.locale = :ru
  end

end
