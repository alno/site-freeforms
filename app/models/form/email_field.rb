class Form::EmailField < Form::Field
  
  EMAIL_REGEXP = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|aero|ag|asia|at|be|biz|ca|cc|cn|com|de|edu|eu|fm|gov|gs|jobs|jp|in|info|me|mil|mobi|museum|ms|name|net|nu|nz|org|tc|tw|tv|uk|us|vg|ws)\z/i
  
  def type
    :email
  end
  
  def render_value( value )
    value
  end
  
  def render_input( form_id, field_num )
    s = "<p id=\"mf_#{form_id}_#{field_num}\" class=\"mf_email\"><label for=\"fields[#{field_num}]\">#{escaped_title}</label><input type=\"text\" name=\"fields[#{field_num}]\""
    s += " value=\"#{escaped_default}\"" if default
    s += " /><span id=\"mfe_#{form_id}_#{field_num}\"></span></p>"
  end
  
  def error_for(value)    
    v = super
    
    return v if v
    return I18n.t('fields.errors.email.invalid') unless value.blank? || value =~ EMAIL_REGEXP
    
    nil
  end
  
end