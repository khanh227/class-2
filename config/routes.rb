Rails.application.routes.draw do
  resources :products 
  devise_for :users
  resources :categories
  resources :product_imports do
    collection { post :import }
  end
end
