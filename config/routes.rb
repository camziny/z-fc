Rails.application.routes.draw do
  get 'home/index'
  get '/profile', to: 'users#profile', as: 'user_profile'
  get 'players/:id', to: 'players#show', as: 'player'
  get '/player_image/:id', to: 'players#image', as: 'player_image'
  get '/nation/:id', to: 'players#nation', as: 'player_nation'
  get '/club/:id', to: 'players#club', as: 'player_club'
  get '/nation_image/:id', to: 'players#nation_image', as: 'nation_image'
  get '/club_image/:id', to: 'players#club_image', as: 'club_image'
  get '/league_image/:id', to: 'players#league_image', as: 'league_image'


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  resources :players
  resources :squads

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'


  namespace :api do
    namespace :v1 do
      resources :players, only: [:index]
    end
  end
  
end
