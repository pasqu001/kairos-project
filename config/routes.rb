Rails.application.routes.draw do

  post 'users/photos/new' => 'users#new_photo'
  post 'users/add_photo' => 'users#add_photo'
  get '/verify_photo' => 'home#verify_photo'
  post '/verify_photo' => 'home#verify_photo'

  resources :users
  resources :events
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
