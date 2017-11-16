Rails.application.routes.draw do
	root 'events#index'
  post 'users/photos/new' => 'users#new_photo'
  post 'users/add_photo' => 'users#add_photo'
  resources :users
  resources :events
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
