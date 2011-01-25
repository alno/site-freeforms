# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def labelling_remote_form_for( object_name, *args, &proc )
    options = args.last.is_a?( Hash ) ? args.pop : {}
    options = options.merge( :builder => LabellingFormBuilder )

    remote_form_for( object_name, *(args << options), &proc )
  end

  def labelling_form_for( object_name, *args, &proc )
    options = args.last.is_a?( Hash ) ? args.pop : {}
    options = options.merge( :builder => LabellingFormBuilder )

    form_for( object_name, *(args << options), &proc )
  end

  def labelling_fields_for( object_name, *args, &proc )
    options = args.last.is_a?( Hash ) ? args.pop : {}
    options = options.merge( :builder => LabellingFormBuilder )

    fields_for( object_name, *(args << options), &proc )
  end

  def styled_link_to( key, url, options = {} )
    link_to( t(key), url, { :class => 'button' }.merge!( options ) )
  end

  def icon_link_to( key, url, options = {} )
    link_to( image_tag( "icons/#{key}.png", :width => 12, :height => 12 ), url, options )
  end

  def color_field_tag(name, value = nil, options = {})
    id = sanitize_to_id(name)
    tag( :input, { :type => "text", :name => name, :id => id, :value => value }.update( options.symbolize_keys ) ) + "<script>$(function(){$('##{id}').addColorPicker();});</script>"
  end

  def font_options_for_select(container, selected = nil)
    container = container.to_a if Hash === container
    selected, disabled = extract_selected_and_disabled(selected)

    options_for_select = container.inject([]) do |options, element|
      text, value = option_text_and_value(element)
      selected_attribute = ' selected="selected"' if option_value_selected?(value, selected)
      disabled_attribute = ' disabled="disabled"' if disabled && option_value_selected?(value, disabled)
      options << %(<option style='font-family: #{html_escape(text.to_s)}'value="#{html_escape(value.to_s)}"#{selected_attribute}#{disabled_attribute}>#{html_escape(text.to_s)}</option>)
    end

    options_for_select.join("\n")
  end

  def font_select_tag(name, value = nil, options = {})
    select_tag( name, font_options_for_select( [ "Arial", "Verdana", "Tahoma", "Times New Roman", "Courier New", "Comic Sans" ], value ), options )
  end

  def page_title
    t( 'titles.' + controller.controller_name + '.' + controller.action_name )
  end

  def without_panel?
    @without_panel
  end

  def without_panel!
    @without_panel = true
  end

end
