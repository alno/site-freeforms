class Message < ActiveRecord::Base
  
  acts_as_accessible_by_key # Доступ по ключу  
  acts_as_paranoid # Не удалять из базы
  
  serialize :data
  
  belongs_to :user
  belongs_to :form
  
  validates_presence_of :form
  validates_presence_of :user
  validates_presence_of :data
  
  named_scope :unread, :conditions => "read_at IS NULL"
  
  # Кол-во сообщений на одну страницу
  def self.per_page
    30
  end
  
  def validate_on_create
    form.fields.each_with_index do |field,i|
      e = field.error_for( data[i] )
      errors.add(i,e) if field.enabled? && e
    end
  end
  
  before_create do |msg|
    msg.token = Authlogic::CryptoProviders::Sha1.encrypt(Time.now.to_s + (1..10).collect{ rand.to_s }.join)
  end
      
end
