Rails.application.routes.draw do
  resources :assignments
  resources :players
  resources :teams

  root 'sessions#welcome'

  # home_path
   get '/home' => 'sessions#home'

   # login_path
   get '/login' => 'sessions#new'

   # create_path
   post '/login' => 'sessions#login'

   # logout_path
   get '/logout' => 'sessions#logout'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
