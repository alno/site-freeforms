class StatsController < ApplicationController
  
  before_filter :require_user, :except => [ :service ]
  
  def index
    @forms = current_user.forms
  end

end
