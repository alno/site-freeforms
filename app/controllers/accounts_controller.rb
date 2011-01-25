class AccountsController < ApplicationController

  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    redirect_to root_url + '#register'
  end

  def create
    current_user_session.destroy if current_user_session

    @user = User.new(params[:account])
    @user.activated_at = Time.now
    @user.password = Authlogic::CryptoProviders::Sha1.encrypt(Time.now.to_s + (1..10).collect{ rand.to_s }.join)[1..7] if @user.password.blank?
    @user.password_confirmation = @user.password

    if @user.save
      #@user.deliver_activation_instructions!
      @user_session = UserSession.create @user

      flash[:notice] = I18n.t('notice.account_registered')

      if params[:form]
        @form = @user.forms.first
        @form.assign params[:form]
        @form.save!

        redirect_to form_path( @form ) + '#form-code'
      else
        redirect_to messages_path
      end

      @user.deliver_signup_notification!
    else
      @form = Form.new
      @form.assign params[:form] if params[:form]

      @user_session = UserSession.new

      render :template => 'root/register'
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
