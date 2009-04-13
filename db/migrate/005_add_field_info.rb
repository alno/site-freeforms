class AddFieldInfo < ActiveRecord::Migration
  class Form < ActiveRecord::Base; serialize :fields; end
  class Message < ActiveRecord::Base; serialize :data; end
  
  def self.up
    add_column :forms, :fields, :text
    add_column :messages, :data, :text
    
    Form.find(:all).each do |f|
      f.fields = [ ::Form::StringField.new( :title => 'Заголовок сообщения' ), ::Form::TextField.new( :title => 'Текст сообщения' ) ]
      f.save
    end
    
    Message.find(:all).each do |m|
      m.data = [ m.title, m.content ]
      m.save
    end
    
    remove_column :messages, :title
    remove_column :messages, :content
  end

  def self.down
    add_column :messages, :title, :string
    add_column :messages, :content, :string
    
    Message.find(:all).each do |m|
      m.title = m.data[0]
      m.content = m.data[1]
      m.save
    end
    
    remove_column :forms, :fields
    remove_column :messages, :data
  end
end
