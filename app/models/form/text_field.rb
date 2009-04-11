class Form::TextField < Form::Field
  
  def type
    :text
  end
  
  def render_value( value )
    "<pre>#{value}</pre>"
  end
  
  def render_input( form_id, field_num )
    "<p id=\"mf_#{form_id}_#{field_num}\"><label for=\"fields[#{field_num}]\">#{escaped_title}</label><textarea name=\"fields[#{field_num}]\">#{escaped_default}</textarea></p>"
  end
  
end