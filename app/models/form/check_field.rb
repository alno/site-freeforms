class Form::CheckField < Form::Field
  
  def type
    :check
  end
  
  def render_value( value )
    value
  end
  
  def render_input( form_id, field_num )
    s = "<p id=\"mf_#{form_id}_#{field_num}\" class=\"mf_check\">"
    s << "<input type=\"hidden\" name=\"fields[#{field_num}]\" value=\"0\" />"
    s << "<input type=\"checkbox\" name=\"fields[#{field_num}]\" value=\"1\" />"
    s << "<label for=\"fields[#{field_num}]\">#{escaped_title}</label>"
    s << "<span id=\"mfe_#{form_id}_#{field_num}\"></span></p>"
    s.html_safe
  end
  
end