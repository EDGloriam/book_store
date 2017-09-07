Rails.application.routes.draw do
  root 'pages#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  get '/users/auth/facebook/callback', to: 'pages#index'

  match '/settings', to: 'profiles#show', via: 'get'
  match '/settings', to: 'profiles#update', via: 'patch'

  resources :books, :orders, :reviews
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
end

