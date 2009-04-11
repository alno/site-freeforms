class Form::Field
  attr_accessor :title
  attr_accessor :default  
  attr_accessor :disabled
  
  def self.create( type, atts )
    "Form::#{type.camelize}Field".constantize.new( atts )
  end
  
  def initialize( atts = {} )
    atts.symbolize_keys!
    atts.each do |k,v|
      self.send "#{k}=".to_sym, v if v && v != ''
    end
  end
  
  def escaped_title
    HTMLEntities.encode_entities(@title, :basic, :decimal) if @title
  end
  
  def escaped_default
    HTMLEntities.encode_entities(@default, :basic, :decimal) if @default
  end
  
  def enabled?
    !@disabled
  end
  
  alias_method :disabled?, :disabled
  
end