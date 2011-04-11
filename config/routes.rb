Freeforms::Application.routes.draw do

  #match '/pages', :to => 'wiki_pages#index', :as => :wiki_root


  resource :account
  resource :session
  resources :account_passwords
  resources :account_activations

  resources :forms do
    member do
      get :code
      get :clone

      get :messages
      get :unread
      get :today
      get :stats
    end
  end

  resources :messages do
    collection do
      get :unread
      get :today
    end
  end

  resources :stats do
    collection do
      get :service
    end
  end

  match '/post/:form_id', :to  => 'root#post', :as => :post_message
  match '/status/:token', :to  => 'root#status', :as => :message_status

  match '/logout', :to  => 'sessions#destroy', :as => :logout
  match '/register', :to  => 'root#register', :as => :register
  match '/restore', :to  => 'root#restore', :as => :restore
  match '/about', :to  => 'root#about', :as => :about
  match '/authors', :to  => 'root#authors', :as => :authors

  root :to  => 'root#index'

end
