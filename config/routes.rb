Rails.application.routes.draw do

  resources :players

  resources :teams do
    resources :assignments
  end
  
  resources :assignments



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
