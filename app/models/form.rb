class Form < ActiveRecord::Base
  
  acts_as_accessible_by_key # Доступ по ключу  
  acts_as_paranoid # Не удалять из базы
  
  serialize :fields # Информация о полях формы в сериализованном виде
  serialize :style # Информация о стиле формы в сериализованном виде
  
  belongs_to :user
  
  has_many :messages, :order => 'created_at DESC'
  
  validates_presence_of :user_id
  
  before_save do |form|
    form.title.strip! if form.title # Удаляем пробелы из начала и конца заголовка
    form.title = "Безымянная форма" if form.title.blank? # Пустой заголовок заменяем на стандартный
  end
  
  def self.per_page
    30
  end
  
  def self.default_fields
    [
      Form::StringField.new( :title => I18n.t( 'form_fields.name' ) ), 
      Form::TextField.new( :title => I18n.t( 'form_fields.content' ) ) 
    ]
  end
    
  def initialize(args = {})
    super(args)
    
    self.submit_title = "Отправить" unless self.submit_title
    self.fields = Form.default_fields unless self.fields
    self.style = Form::Style.new unless self.style
  end
  
  def assign(args)
    self.title = args[:title]
    self.submit_title = args[:submit_title]
    self.description = args[:description]
    
    self.style = Form::Style.new( args[:style] ) # Устанавливаем стиль формы
    
    if args[:fields] # Если заданы поля формы
      self.fields = []
      
      args[:fields].each do |f|
        self.fields << Form::Field.create( f[:type], :title => f[:title], :default => f[:default], :disabled => (f[:enabled].to_i != 1) )
      end      
    end
  end
  
  def code(type = nil)
    return "<a href=\"#{code_url(:html)}\" target=\"_blank\" onclick=\"window.open('#{code_url(:html)}','wn'+Math.round(Math.random()*1000),'fullscreen=no,width=500,height=330,scrollbars=no,status=no,toolbar=no,menubar=no,resizable=no');return false;\">Отправить сообщение</a>" if type == :popup
    
    "<script src=\"#{code_url(:js)}\"></script>"
  end
  
  def code_url(format)
    "http://#{JS_HOST}#{FORM_CODE_PREFIX}/#{id}#{FORM_CODE_SUFFIX}.#{format}"
  end
  
  INNER_CLASSES = [ Form::Style, Form::StringField, Form::TextField, Form::EmailField ] # Необходимо, чтобы корректно десериализовались данные
  
end