class Form::Field
    
  attr_accessor :title
  attr_accessor :default  
  attr_accessor :disabled
  attr_accessor :required
  
  def self.create( type, atts )
    "Form::#{type.camelize}Field".constantize.new( atts )
  end
  
  def initialize( atts = {} )
    @disabled = false
    @required = false
    
    atts.each do |k,v|
      self.send "#{k}=", v
    end
  end
  
  def escaped_title
    HTMLEntities.encode_entities(@title, :basic, :decimal) if @title
  end
  
  def escaped_default
    HTMLEntities.encode_entities(@default, :basic, :decimal) if @default
  end
    
  def error_for(value)
    return I18n.t('fields.errors.field.missed') if required && value.blank?    
    nil
  end
    
  def enabled?; !disabled; end
  def disabled?; disabled; end
  def required?; required; end
  
end