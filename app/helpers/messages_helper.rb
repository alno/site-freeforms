module MessagesHelper
  
  def message_body( message )
    str = ''
    
    message.form.fields.each_with_index do |field,i|
      if field.type != :text
        str << ', ' unless str.empty?
        str << ( field.render_value( message.data[i] ) || ' ' )
      end
    end
            
    truncate( str, :length => 300 )    
  end
  
end
