Rails.application.routes.draw do
  root 'home#index'
  resources :products
  devise_for :users
  resources :categories
  resources :lunch_orders, only: [:index, :show] do
    resources :customer_orders
  end
  resources :menus
  resources :product_imports do
    collection { post :import }
  end
end
