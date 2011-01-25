class AddEmailAndTitleFields < ActiveRecord::Migration
  class Form < ActiveRecord::Base; serialize :fields; end
  class Message < ActiveRecord::Base; serialize :data; end

  def self.up
    Form.find(:all).each do |f|
      f.fields.insert( 0, ::Form::EmailField.new( :title => I18n.t( 'form_fields.email' ), :required => true ) )
      f.fields.insert( 1, ::Form::StringField.new( :title => I18n.t( 'form_fields.name' ) ) )
      f.save
    end

    Message.find(:all).each do |m|
      m.data.insert( 0, m.sender_email )
      m.data.insert( 1, m.sender_name )
      m.save
    end

    remove_column :messages, :sender_name
    remove_column :messages, :sender_email
  end

  def self.down
    add_column :messages, :sender_name, :string
    add_column :messages, :sender_email, :string

    Message.find(:all).each do |m|
      m.sender_email = m.data.shift
      m.sender_name = m.data.shift
      m.save
    end

    Form.find(:all).each do |f|
      f.fields.shift
      f.fields.shift
      f.save
    end
  end
end
