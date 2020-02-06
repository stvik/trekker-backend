Rails.application.routes.draw do
  resources :users, only: [:index, :create, :update]
  get '/users/login', to: 'users#login', as: 'login'
  resources :user_countries
  resources :cities
  resources :countries, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
