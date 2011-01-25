class User < ActiveRecord::Base

  acts_as_accessible_by_key # Доступ по ключу
  acts_as_authentic # Аутентификация
  acts_as_paranoid # Не удалять из базы

  has_many :messages, :order => 'created_at DESC'
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

  def deliver_signup_notification!
    UserMailer.deliver_signup_notification(self)
  end

  def activated
    !!activated_at
  end

  def activated=(value)
    self.activated_at = ( value && value != 0 && value != "0" ? Time.now : nil )
  end

  alias_method :active?, :activated
  alias_method :activated?, :activated

end
