Rails.application.routes.draw do
  resources :users
  resources :user_countries
  resources :cities
  resources :countries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
