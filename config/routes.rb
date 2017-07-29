Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :books
  root 'pages#index'
  get '/users/auth/facebook/callback', to: 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
# , controllers: {omniauth_callbacks: 'omniauth_callbacks'}