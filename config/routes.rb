Rails.application.routes.draw do
  resources :assignments
  resources :players
  resources :teams

  root 'sessions#welcome'

  # home_path
 get '/home' => 'sessions#home'


   get '/login' => 'sessions#new'
   post 'sessions' => 'sessions#create'
   get '/logout'=> 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
