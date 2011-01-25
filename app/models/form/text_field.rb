class Form::TextField < Form::Field
  
  def type
    :text
  end
  
  def render_value( value )
    "<pre>#{value}</pre>".html_safe
  end
  
  def render_input( form_id, field_num )
    "<p id=\"mf_#{form_id}_#{field_num}\" class=\"mf_text\"><label for=\"fields[#{field_num}]\">#{escaped_title}</label><span id=\"mfe_#{form_id}_#{field_num}\"></span><textarea name=\"fields[#{field_num}]\">#{escaped_default}</textarea></p>".html_safe
  end
  
end