class User < ActiveRecord::Base
  
  acts_as_authentic
  acts_as_paranoid # Не удалять из базы
  
  has_many :messages
  has_many :forms
    
  after_create do |user|
    user.forms.create!( :title => I18n.t( :default_form_title ), :description => I18n.t( :default_form_description ) )
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.deliver_activation_instructions(self)
  end
      
  def active?
    activated_at
  end

end
