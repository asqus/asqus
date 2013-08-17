Asqus::Application.routes.draw do
  
  resources :offices, :only => [:index, :show]
  resources :officials, :only => [:index, :show]
  resources :quick_poll_responses
  resources :quick_poll_results

  resources :states do
    resources :municipalities do
      resources :wards
    end
    resources :postal_cities

  end
  
  resources :tags
  resources :zip_codes, :only => [:index, :show]
  
  

  namespace :admin do
    resources :counties
    resources :delayed_jobs
    resources :officials
    resources :offices

    resources :standard_poll_option_sets
    resources :states do
      resources :municipalities do
        resources :wards
      end
    end
    
    resources :users
    
  end
  
  
  namespace :staff do
    resources :issues
    resources :official_mailings
    resources :quick_polls
  end
  

  authenticated :user do
    root :to => 'home#home'
  end
  root :to => "home#index"
 
  match '/admin' => "admin/home#index"
  match '/staff' => "staff/home#index"
  
  devise_for :users, :path_prefix => 'd', :controllers => {:registrations => 'registrations'}

  match '/auth/:provider/callback' => 'authentications#create'
  resources :authentications, :only => [:index,:create,:destroy]
  match '/auth/failure' => 'authentications#auth_failure'



end