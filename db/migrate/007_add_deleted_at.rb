class AddDeletedAt < ActiveRecord::Migration
  def self.up
    add_column :users, :deleted_at, :timestamp
    add_column :forms, :deleted_at, :timestamp
    add_column :messages, :deleted_at, :timestamp
  end

  def self.down
    remove_column :users, :deleted_at
    remove_column :forms, :deleted_at
    remove_column :messages, :deleted_at
  end
end
