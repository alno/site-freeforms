class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = APP_HOST

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
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

end
