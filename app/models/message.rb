class Message < ActiveRecord::Base

  acts_as_accessible_by_key # Доступ по ключу
  acts_as_paranoid # Не удалять из базы

  serialize :data

  belongs_to :user
  belongs_to :form

  validates_presence_of :form
  validates_presence_of :user
  validates_presence_of :data

  scope :unread, :conditions => "read_at IS NULL"
  scope :today, lambda { { :conditions => [ "created_at > ?", Time.now - 24.hours ] } }

  validate :check_fields, :on => :create

  # Кол-во сообщений на одну страницу
  def self.per_page
    20
  end

  def mark_read!
    update_attribute :read_at, Time.now unless self[:read_at]
  end

  before_create do |msg|
    msg.token = Authlogic::CryptoProviders::Sha1.encrypt(Time.now.to_s + (1..10).collect{ rand.to_s }.join)
  end

  after_create do |msg|
    UserMailer.send_later :deliver_message_notification, msg.user, msg.form, msg if msg.form.subscribed
  end

  private

  def check_fields
    form.fields.each_with_index do |field,i|
      e = field.error_for( data[i] )
      errors.add(i,e) if e
    end
  end

end
