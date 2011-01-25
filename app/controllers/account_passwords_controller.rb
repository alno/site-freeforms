class AccountPasswordsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:show, :update]

  def create
    @user = User.find_by_email(params[:account_password][:email])

    if @user
      @user.deliver_password_reset_instructions!

      flash[:notice] = I18n.t('notice.reset_instructions_sent')
    else
      flash[:error] = I18n.t('error.no_user_found')
    end

    redirect_to root_url
  end

  def show
  end

  def update
    @user.password = params[:account_password][:password]
    @user.password_confirmation = params[:account_password][:password_confirmation]
    @user.activated_at = Time.now unless @user.activated_at

    if @user.save
      flash[:notice] = I18n.t('notice.password_updated')
      redirect_to account_url
    else
      render :action => :show
    end
  end

end
