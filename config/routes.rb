Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products 
  resources :product_imports do
    collection { post :import }
  end
end
