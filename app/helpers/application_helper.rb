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
  
end
