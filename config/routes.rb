Rails.application.routes.draw do
  get 'home/index'
  get 'users/profile', to: 'users#profile', as: :user_profile

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
