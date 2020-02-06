Rails.application.routes.draw do
  resources :reviews, only: [:index, :create]
  resources :users, only: [:index, :create, :update]
  get '/users/login', to: 'users#login', as: 'login'
  resources :user_countries, only: [:index, :create, :destroy]
  resources :cities, only: [:index]
  resources :countries, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
