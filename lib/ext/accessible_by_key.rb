module Ext::AccessibleByKey
  
  def self.included(base)
    
    base.validates_uniqueness_of :access_key # Ключ доступа должен быть уникальным
    
    base.before_create :generate_access_key # Генерируем ключ доступа при создании записи
    
  end
  
  # Сгенерировать новый ключ доступа  
  def generate_access_key
    self.access_key = Authlogic::CryptoProviders::Sha1.encrypt(Time.now.to_s + (1..10).collect{ rand.to_s }.join)
  end
  
  # Обновить ключ доступа записи
  def update_access_key
    generate_access_key
    save
  end
  
  def update_access_key!
    generate_access_key
    save!
  end
  
end