class Message < ActiveRecord::Base
  
  serialize :data
  
  belongs_to :user
  belongs_to :form
  
  validates_presence_of :form
  validates_presence_of :user
  validates_presence_of :data
  
  validates_length_of :sender_email, :within => 6..100
  validates_format_of :sender_email, :with => /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|aero|ag|asia|at|be|biz|ca|cc|cn|com|de|edu|eu|fm|gov|gs|jobs|jp|in|info|me|mil|mobi|museum|ms|name|net|nu|nz|org|tc|tw|tv|uk|us|vg|ws)\z/i
  
  named_scope :unread, :conditions => "read_at IS NULL"
  
  before_create do |msg|
    msg.token = Authlogic::CryptoProviders::Sha1.encrypt(Time.now.to_s + (1..10).collect{ rand.to_s }.join)
  end
      
end
