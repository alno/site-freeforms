module FormsHelper

  def e(str)
    HTMLEntities.encode_entities(str, :basic, :decimal).html_safe
  end

  def wrap_style( form )
    style = form.style

    s = "border: #{style.border_width}px solid #{style.border_color};background: #{style.background};"
    s << "font-family: #{style.font_family};font-size: #{style.font_size}px;color: #{style.font_color};"
    s << border_radius( style.border_radius ) if style.border_radius.to_i > 0

    s
  end

  def header_style( form )
    style = form.style

    "font-family: #{style.title_family};font-size: #{style.title_size}px;color: #{style.title_color};"
  end

  def fb_style( form )
    style = form.style

    s = ""
    s << border_radius( style.border_radius ) if style.border_radius.to_i > 0

    s
  end

  def border_radius( radius )
    "-moz-border-radius: #{radius}px;-khtml-border-radius: #{radius}px;-webkit-border-radius: #{radius}px;border-radius: #{radius}px;"
  end

  def form_html( form )
    render( :partial => 'forms/code.html', :locals => { :form => form } ).gsub( /\s*\n\s*/, '' ).html_safe
  end

  def field_editor_remove
    image_tag 'icons/delete.png', :class => 'act_icon', :onclick => "formEditor.removeField($(this))", :alt => t( 'tooltips.fields.delete' )
  end

  def field_prototype( form, type, title )
    field = Form::Field.create( type, :title => title )
    index = "#{type}_proto"

    html = field.render_input( form.id, index )
    html << "<div id=\"fe_#{form.id}_#{index}\" class=\"form_editor\">".html_safe
    html << render( :partial => "forms/editor/fields/#{type}", :locals => { :field => field, :index => index, :form => form } )
    html << "</div>".html_safe
  end

end
