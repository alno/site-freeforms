class AddFormAliases < ActiveRecord::Migration

  def self.up
    add_column :forms, :alias, :string
    
    Form.update_all "alias = title"
  end
  
  def self.down
    remove_column :forms, :alias, :string
  end
  
end