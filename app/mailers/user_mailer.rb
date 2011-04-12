class UserMailer < ActionMailer::Base

  default_url_options[:host] = APP_HOST

  def password_reset_instructions(user)
    subject       "Восстановление пароля на freeforms.ru"
    from          "noreply@#{MAIL_HOST}"
    recipients    user.email
    sent_on       Time.now

    @password_reset_url = account_password_url(user.perishable_token)
  end

  def activation_instructions(user)
    subject       "Account Activation Instructions"
    from          "noreply@#{MAIL_HOST}"
    recipients    user.email
    sent_on       Time.now

    @activation_url = account_activation_url(user.perishable_token)
  end

  def signup_notification(user)
    subject       "Регистрация на freeforms.ru"
    from          "noreply@#{MAIL_HOST}"
    recipients    user.email
    sent_on       Time.now

    @user_email = user.email
    @user_password = user.password
    @form_url = form_url( user.forms.first ) + '#form-code' unless user.forms.empty?
    @restore_password_url = restore_url
  end

  def message_notification(user,form,msg)
    subject       "Новое сообщение на форму '#{form.alias}'"
    from          "noreply@#{MAIL_HOST}"
    recipients    user.email
    sent_on       Time.now

    @message = msg
    @form = form
  end

end
