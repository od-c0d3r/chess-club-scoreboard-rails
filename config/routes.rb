Rails.application.routes.draw do
  resources :users
  resources :matches, only: [:index, :new, :create]
  
  root 'users#index'
end
