class UserMailer < ActionMailer::Base

  default_url_options[:host] = APP_HOST
  default :from => "noreply@#{MAIL_HOST}"

  def password_reset_instructions(user)
    @password_reset_url = account_password_url(user.perishable_token)

    mail :to => user.email, :subject => "Восстановление пароля на freeforms.ru"
  end

  def activation_instructions(user)
    @activation_url = account_activation_url(user.perishable_token)

    mail :to => user.email, :subject => "Account Activation Instructions"
  end

  def signup_notification(user)
    @user_email = user.email
    @user_password = user.password
    @form_url = form_url( user.forms.first ) + '#form-code' unless user.forms.empty?
    @restore_password_url = restore_url

    mail :to => user.email, :subject => "Регистрация на freeforms.ru"
  end

  def message_notification(user,form,msg)
    @message = msg
    @form = form

    mail :to => user.email, :subject => "Новое сообщение на форму '#{form.alias}'"
  end

end
