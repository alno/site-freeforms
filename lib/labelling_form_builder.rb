class LabellingFormBuilder < ActionView::Helpers::FormBuilder
  
  def smart_label( field, options = {} )
    label( field, I18n.t( 'activerecord.attributes.' + object_name.to_s + '.' + field.to_s ), options )
  end
  
  def submit_update( options = {} )
    submit( I18n.t('actions.' + object_name.to_s + '.update'), options )
  end
  
  def submit_create( options = {} )
    submit( I18n.t('actions.' + object_name.to_s + '.create'), options )
  end
      
  (field_helpers - %w(check_box radio_button hidden_field label)).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {})
        '<p class="' + field.to_s + '">' + smart_label( field ) + super + '</p>'
      end
    END_SRC
        
    class_eval src, __FILE__, __LINE__
  end
      
  %w(check_box radio_button).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {})
        '<p class="' + field.to_s + '">' + super + smart_label( field ) + '</p>'
      end
    END_SRC
        
    class_eval src, __FILE__, __LINE__
  end
      
end