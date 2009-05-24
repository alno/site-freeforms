class Form::Style
  
  attr_writer :background, :font_family, :font_size, :font_color, :title_family, :title_size, :title_color
  
  def initialize( atts = {} )
    atts.each do |k,v|
      self.send "#{k}=".to_sym, v if v && v != '' && v != self.send( k )
    end
  end
  
  def background
    @background || '#fff'
  end
  
  def font_family
    @font_family || 'Verdana'
  end
  
  def font_size
    @font_size || 15
  end
  
  def font_color
    @font_color || '#000'
  end  
  
  def title_family
    @title_family || 'Verdana'
  end
  
  def title_size
    @title_size || 18
  end
  
  def title_color
    @title_color || '#000'
  end
  
end