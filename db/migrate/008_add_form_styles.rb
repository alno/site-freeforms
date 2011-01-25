class AddFormStyles < ActiveRecord::Migration

  class Form < ActiveRecord::Base; serialize :style; end

  def self.up
    add_column :forms, :style, :text
    add_column :forms, :submit_title, :string

    Form.find(:all).each do |f|
      f.style = ::Form::Style.new
      f.submit_title = "Отправить"
      f.save
    end
  end

  def self.down
    remove_column :forms, :style
    remove_column :forms, :submit_title
  end
end
