Rails.application.routes.draw do
  root 'home#index'
  resources :products
  devise_for :users
  resources :categories
end