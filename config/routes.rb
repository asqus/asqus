Asqus::Application.routes.draw do
  

  resources :quick_poll_responses

  resources :quick_poll_results

  resources :tags

  resources :poll_options

  resources :user_groups

  resources :poll_responses

  resources :poll_questions

  resources :offices, :only => [:index, :show]

  resources :state_senate_districts

  resources :state_house_districts
  
  resources :congressional_districts

  resources :municipalities do
    resources :wards
  end

  namespace :admin do
    resources :officials
    resources :offices
    resources :states, :only => [:index, :show, :edit, :update]
    resources :users
    resources :standard_poll_option_sets
    resources :counties
  end
  
  
  namespace :staff do
    resources :quick_poll_options
    resources :quick_polls
    resources :issues
  
  end
  
  resources :officials, :only => [:index, :show]

 
  authenticated :user do
    root :to => 'home#home'
  end
  root :to => "home#index"
 

  match '/admin' => 'home#admin'

  devise_for :users

  match '/auth/:provider/callback' => 'authentications#create'
  resources :authentications, :only => [:index,:create,:destroy]
  match '/auth/failure' => 'authentications#auth_failure'



end