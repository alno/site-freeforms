class AddAccessKeys < ActiveRecord::Migration
  
  class User < ActiveRecord::Base; acts_as_accessible_by_key; end
  class Form < ActiveRecord::Base; acts_as_accessible_by_key; end
  class Message < ActiveRecord::Base; acts_as_accessible_by_key; end
  
  def self.up
    add_column :users, :access_key, :string
    add_column :forms, :access_key, :string
    add_column :messages, :access_key, :string
    
    add_index :users, :access_key
    add_index :forms, :access_key
    add_index :messages, :access_key
    
    User.find(:all).each do |u|
      u.update_access_key!
    end
    
    Form.find(:all).each do |u|
      u.update_access_key!
    end
    
    Message.find(:all).each do |u|
      u.update_access_key!
    end
  end

  def self.down
    remove_index :users, :access_key
    remove_index :forms, :access_key
    remove_index :messages, :access_key
    
    remove_column :users, :access_key
    remove_column :forms, :access_key
    remove_column :messages, :access_key    
  end

end
