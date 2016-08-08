Rails.application.routes.draw do



  root 'pages#home'

  devise_for 	:users,
  				:path => '',
  				:path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
 				:controllers => {:omniauth_callbacks => 'omniauth_callbacks',
 				:registrations => 'registrations'
 				} 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  resources :trainings
  resources :photos

  resources :trainings do
  	resources :reservations, only: [:create]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get '/preload' => 'reservations#preload'

  get '/your_trips' => 'reservations#your_trips'
  get '/your_reservations' => 'reservations#your_reservations'

end
