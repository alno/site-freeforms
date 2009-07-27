class Form::Style
  
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
  
  def initialize( atts = {} )
    atts.each do |k,v|
      self.send "#{k}=".to_sym, v if v && v != '' && v != self.send( k )
    end
  end
  
  attr_with_default :background, '#fff'  
  
  attr_with_default :font_family, 'Verdana'
  attr_with_default :font_size, 15
  attr_with_default :font_color, '#000'
  
  attr_with_default :title_family, 'Verdana'
  attr_with_default :title_size, 18
  attr_with_default :title_color, '#000'
  
  attr_with_default :border_color, '#f00'
  attr_with_default :border_width, 2
  attr_with_default :border_radius, 0
  
end