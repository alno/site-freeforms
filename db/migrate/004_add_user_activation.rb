class AddUserActivation < ActiveRecord::Migration
  def self.up
    add_column :users, :activated_at, :datetime

    add_index :users, :email
    add_index :users, :persistence_token
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :persistence_token

    remove_column :users, :activated_at
  end
end
