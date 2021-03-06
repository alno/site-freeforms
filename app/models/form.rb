class Form < ActiveRecord::Base

  acts_as_accessible_by_key # Доступ по ключу
  acts_as_paranoid # Не удалять из базы

  serialize :fields # Информация о полях формы в сериализованном виде
  serialize :style # Информация о стиле формы в сериализованном виде

  belongs_to :user

  has_many :messages, :order => 'forms.created_at DESC'

  scope :active_in, lambda{|time| where('(SELECT COUNT(id) FROM messages WHERE created_at <= ? AND created_at >= ? AND form_id = forms.id) > 0', time, time - 1.week) }

  validates_presence_of :user, :submit_title, :title, :alias

  before_validation do |form|
    form.title.strip! if form.title # Удаляем пробелы из начала и конца заголовка
    form.title = "Безымянная форма" if form.title.blank? # Пустой заголовок заменяем на стандартный
    form.alias = "Новая форма" if form.alias.blank?
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

    self.title = "Моя форма" unless self.title
    self.submit_title = "Отправить" unless self.submit_title
    self.fields = Form.default_fields unless self.fields
    self.style = Form::Style.new unless self.style
  end

  def assign(args)
    self.title = args[:title] if args[:title]
    self.alias = args[:alias] if args[:alias]
    self.submit_title = args[:submit_title] if args[:submit_title]
    self.description = args[:description] if args[:description]
    self.subscribed = args[:subscribed] unless args[:subscribed].blank?

    self.style = Form::Style.new( args[:style] ) if args[:style] # Устанавливаем стиль формы

    if args[:fields] # Если заданы поля формы
      self.fields = []

      args[:fields].each do |f|
        self.fields << Form::Field.create( f[:type], f )
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

  def support_stats?
    !!fields.detect(&:support_stats?)
  end

  INNER_CLASSES = [ Form::Style, Form::StringField, Form::TextField, Form::EmailField, Form::SelectField, Form::RadioField, Form::CheckField ] # Необходимо, чтобы корректно десериализовались данные

end
