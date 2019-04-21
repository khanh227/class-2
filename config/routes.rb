Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users

  get 'categories/index'
  resources :categories
  root 'categories#index'

end
