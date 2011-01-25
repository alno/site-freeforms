class AccountActivationsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show]

  def show
    unless @user.activated_at
      @user.activated_at = Time.now
      @user.save
    end

    @user_session = UserSession.new( @user )

    if @user_session.save
      flash[:notice] = I18n.t('notice.account_activated')
      redirect_to form_url( @user.forms.first )
    else
      flash[:error] = I18n.t('error.wrong_login_or_password')
      redirect_to root_url
    end
  end

end
