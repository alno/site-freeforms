class Form < ActiveRecord::Base
  
  serialize :fields
  
  belongs_to :user
  
  has_many :messages  
  
  validates_presence_of :user_id
  
  before_create do |form|
    form.fields = [ Form::EmailField.new( :title => I18n.t( 'form_fields.email' ), :required => true ), Form::StringField.new( :title => I18n.t( 'form_fields.name' ) ), StringField.new( :title => I18n.t( 'form_fields.title' ) ), TextField.new( :title => I18n.t( 'form_fields.content' ) ) ] unless form.fields
  end
  
  def code(type = nil)
    return "<a href=\"#{code_url(:html)}\" target=\"_blank\" onclick=\"window.open('#{code_url(:html)}','wn'+Math.round(Math.random()*1000),'fullscreen=no,width=500,height=330,scrollbars=no,status=no,toolbar=no,menubar=no,resizable=no');return false;\">Отправить сообщение</a>" if type == :popup
    
    "<script src=\"#{code_url(:js)}\"></script>"
  end
  
  def code_url(format)
    "http://#{JS_HOST}#{FORM_CODE_PREFIX}/#{id}#{FORM_CODE_SUFFIX}.#{format}"
  end
  
  FIELD_TYPES = [ Form::StringField, Form::TextField, Form::EmailField ] # Необходимо, чтобы корректно десериализовались данные
  
end