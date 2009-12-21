class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = APP_HOST

  def password_reset_instructions(user)
    subject       "Восстановление пароля на freeforms.ru"
    from          "FreeForms Notifier <noreply@#{MAIL_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :password_reset_url => account_password_url(user.perishable_token)
  end
  
  def activation_instructions(user)
    subject       "Account Activation Instructions"
    from          "FreeForms Notifier <noreply@#{MAIL_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :activation_url => account_activation_url(user.perishable_token)
  end
  
  def signup_notification(user)
    args = {}
    args[:user_email] = user.email
    args[:user_password] = user.password
    args[:form_url] = form_url( user.forms.first ) + '#form-code' unless user.forms.empty?
    args[:restore_password_url] = restore_url
    
    subject       "Регистрация на freeforms.ru"
    from          "FreeForms Notifier <noreply@#{MAIL_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          args
  end
  
  def message_notification(user,form,msg)
    subject       "Новое сообщение на форму '#{form.alias}'"
    from          "FreeForms Notifier <noreply@#{MAIL_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :message => msg, :form => form
  end

end
