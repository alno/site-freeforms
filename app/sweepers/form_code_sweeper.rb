class FormCodeSweeper < ActionController::Caching::Sweeper
  observe Form

  def after_save(form)
    expire_page(:controller => "forms", :action => %w( code ), :id => form.id, :format => :html )
    expire_page(:controller => "forms", :action => %w( code ), :id => form.id, :format => :js )
  end
  
end
