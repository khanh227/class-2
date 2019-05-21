Rails.application.routes.draw do
  root 'home#index'
  resources :products
  devise_for :users
  resources :categories
  resources :lunch_orders, only: [:index, :show]
  resources :customer_orders do
      post 'cancel'
  end
  resources :menus
  resources :product_imports do
    collection { post :import }
  end
end
