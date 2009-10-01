module FormsHelper
  
  def e(str)
    HTMLEntities.encode_entities(str, :basic, :decimal)
  end
  
  def wrap_style( form )
    style = form.style
    
    s = "border: #{style.border_width}px solid #{style.border_color};background: #{style.background};"
    s << "font-family: #{style.font_family};font-size: #{style.font_size}px;color: #{style.font_color};"
    
    if style.border_radius.to_i > 0
      s << "-moz-border-radius: #{style.border_radius}px;-khtml-border-radius: #{style.border_radius}px;-webkit-border-radius: #{style.border_radius}px;border-radius: #{style.border_radius}px;"
    end
    
    s
  end
  
  def header_style( form )
    style = form.style
    
    "font-family: #{style.title_family};font-size: #{style.title_size}px;color: #{style.title_color};"
  end
  
  def fb_style( form )
    style = form.style
    
    if style.border_radius.to_i > 0
      "-moz-border-radius: #{style.border_radius}px;-khtml-border-radius: #{style.border_radius}px;-webkit-border-radius: #{style.border_radius}px;border-radius: #{style.border_radius}px;"
    else
      ""
    end
  end
  
  def form_html( form )
    render( :partial => 'forms/code.html', :locals => { :form => form } ).gsub( /\s*\n\s*/, '' )
  end
  
  def field_editor_remove
    image_tag 'icons/delete.png', :class => 'act_icon', :onclick => "formEditor.removeField($(this))", :alt => t( 'tooltips.fields.delete' )
  end
  
end
