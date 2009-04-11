class Form::StringField < Form::Field
  
  def type
    :string
  end
  
  def render_value( value )
    value
  end
  
  def render_input( form_id, field_num )
    s = "<p id=\"mf_#{form_id}_#{field_num}\"><label for=\"fields[#{field_num}]\">#{escaped_title}</label><input type=\"text\" name=\"fields[#{field_num}]\""
    s += " value=\"#{escaped_default}\"" if default
    s += " /></p>"
  end
  
end