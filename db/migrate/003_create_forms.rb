class CreateForms < ActiveRecord::Migration
  class User < ActiveRecord::Base; end
  class Form < ActiveRecord::Base; end
  class Message < ActiveRecord::Base; end
    
  def self.up
    create_table :forms do |t|
      t.integer :user_id
      t.string :title
      t.string :description

      t.timestamps
    end
    
    add_column :messages, :form_id, :integer
    add_index :messages, :form_id
    
    User.find(:all).each do |u|
      f = Form.create( :user_id => u.id, :title => 'Контактная форма', :description => 'Контактная форма' )
      Message.find(:all,:conditions => [ "user_id = ?", u.id ]).each do |m|
        m.form_id = f.id
        m.save!
      end
    end
  end

  def self.down
    remove_index :messages, :form_id
    remove_column :messages, :form_id
    
    drop_table :forms
  end
end
