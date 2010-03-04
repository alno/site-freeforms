class Form::Style < Styles::Base

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

  def name
    'basic'
  end

end