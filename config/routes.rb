ActionController::Routing::Routes.draw do |map|

  map.wiki_root '/pages'
  
  map.resources :forms, :member => [ :code, :clone, :messages, :unread, :today ]  
  map.resources :messages, :collection => [ :unread, :today ]
    
  map.resource :account
  map.resource :session
  
  map.resources :account_passwords
  map.resources :account_activations  
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.post_message '/post/:form_id', :controller => 'root', :action => 'post'
  map.message_status '/status/:token', :controller => 'root', :action => 'status'
    
  map.root :controller => 'root', :action => 'index'  
  map.register '/register', :controller => 'root', :action => 'register'
  map.about '/about', :controller => 'root', :action => 'about'
  
  map.connect '/:id.:format', :controller => 'forms', :action => 'code'
  
  map.connect ':controller.:format'
  map.connect ':controller/:action/:id.:format'
end
