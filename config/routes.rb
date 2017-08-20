Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'
  get '/users/auth/facebook/callback', to: 'pages#index'
  get '/settings', to: 'profiles#show'
  match '/settings', to: 'profiles#update', via: 'patch'
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :books, :orders, :reviews

end

