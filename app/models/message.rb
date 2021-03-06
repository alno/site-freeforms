class Message < ActiveRecord::Base

  acts_as_accessible_by_key # Доступ по ключу
  acts_as_paranoid # Не удалять из базы

  serialize :data

  belongs_to :user
  belongs_to :form

  validates_presence_of :form
  validates_presence_of :user
  validates_presence_of :data

  scope :unread, :conditions => "messages.read_at IS NULL"
  scope :today, lambda { { :conditions => [ "messages.created_at > ?", Time.now - 24.hours ] } }

  default_scope includes(:form)

  validate :check_fields, :on => :create

  before_validation :setup_user, :on => :create

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
    UserMailer.delay.message_notification msg.user, msg.form, msg if msg.form.subscribed
  end

  private

  def check_fields
    form.fields.each_with_index do |field,i|
      e = field.error_for( data[i] )
      errors.add("f#{i}",e) if e
    end
  end

  def setup_user
    self.user = form.user
  end

end
