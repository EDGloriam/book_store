Rails.application.routes.draw do
  root 'pages#index'
  get '/users/auth/facebook/callback', to: 'pages#index'
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
