Rails.application.routes.draw do
  root 'home#index'
  resources :products
  devise_for :users
  resources :categories
  resources :lunch_orders
  resources :product_imports do
    collection { post :import }
  end
end
