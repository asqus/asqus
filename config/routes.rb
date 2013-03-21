Asqus::Application.routes.draw do
  
  resources :municipalities do
    resources :wards
  end
    
  resources :quick_poll_responses

  resources :quick_poll_results

  resources :tags

  resources :offices, :only => [:index, :show]
  resources :officials, :only => [:show]

  namespace :admin do
    resources :officials
    resources :offices
    resources :states, :only => [:index, :show, :edit, :update]
    resources :users
    resources :standard_poll_option_sets
    resources :counties
  end
  
  
  namespace :staff do
    resources :quick_polls
    resources :issues
  end
  
  resources :officials, :only => [:index, :show]

 
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