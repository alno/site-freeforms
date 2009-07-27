class Form::Field
  
  def self.attr_with_default( attr, default )
    src = <<-END_SRC
      def #{attr}
        @#{attr} || '#{default}'
      end
      
      def #{attr}=(v)
        @#{attr} = v
      end
    END_SRC
    
    class_eval src, __FILE__, __LINE__
  end
  
  attr_with_default :title, nil
  attr_with_default :default, nil
  attr_with_default :disabled, false
  attr_with_default :required, false
  
  def self.create( type, atts )
    "Form::#{type.camelize}Field".constantize.new( atts )
  end
  
  def initialize( atts = {} )
    atts.each do |k,v|
      self.send "#{k}=".to_sym, v if v && v != '' && v != self.send( k )
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
  
  def error_for(value)
    return required? ? I18n.t('fields.errors.field.missed') : nil if value.blank?    
    nil
  end
    
  alias_method :disabled?, :disabled
  alias_method :required?, :required
  
end