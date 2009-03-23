ActionController::Routing::Routes.draw do |map|
  
  map.resources :messages, :collection => [ :unread, :unaswered ]
  map.resources :users
  
  map.resource :account, :controller => 'users'
  map.resource :session
  
  map.root :controller => 'root', :action => 'index'
  
  map.post_message '/post/:user_id', :controller => 'root', :action => 'post'
  map.message_status '/status/:token', :controller => 'root', :action => 'status'
end
