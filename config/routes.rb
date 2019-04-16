Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users
	resources :books do
		resources :reviews
	end
	root 'books#index'  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	mount ActionCable.server => 'cable'
end
