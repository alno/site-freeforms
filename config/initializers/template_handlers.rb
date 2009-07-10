require 'txt_builder'

ActionView::Template.register_template_handler 'txtbuilder', ActionView::TemplateHandlers::TxtBuilder

