class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :parent_id
      t.integer :user_id
      t.string :token
      t.string :title
      t.string :content
      t.string :sender_name
      t.string :sender_email

      t.timestamp :read_at
      t.timestamps
    end

    add_index :messages, :parent_id
    add_index :messages, :user_id
    add_index :messages, :token
  end

  def self.down
    remove_index :messages, :parent_id
    remove_index :messages, :user_id
    remove_index :messages, :token

    drop_table :messages
  end
end
