class AddFormSubscription < ActiveRecord::Migration
  
  def self.up
    add_column :forms, :subscribed, :boolean, :default => true
  end

  def self.down
    remove_column :forms, :subscribed
  end

end
