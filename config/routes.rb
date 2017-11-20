Rails.application.routes.draw do
	root 'events#index'
  post 'users/photos/new' => 'users#new_photo'
  post 'users/add_photo' => 'users#add_photo'
  get 'events/:id/verify_photo' => 'events#verify_photo', as: :verify_photo

  post 'events/:id/verify_photo' => 'events#send_photo', as: :post_photo

  resources :users
  resources :events

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'admins#new'
  post '/admins' => 'admins#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
