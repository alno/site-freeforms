ActionController::Routing::Routes.draw do |map|
  
  map.resources :forms, :member => [ :code ] do |m|
    m.resources :messages, :collection => [ :unread, :unanswered ]
  end
  
  map.resources :messages
    
  map.resource :account
  map.resource :session
  
  map.resources :account_passwords
  map.resources :account_activations
  
  map.root :controller => 'root', :action => 'index'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.post_message '/post/:form_id', :controller => 'root', :action => 'post'
  map.message_status '/status/:token', :controller => 'root', :action => 'status'
    
  map.about '/about', :controller => 'root', :action => 'about'
end
