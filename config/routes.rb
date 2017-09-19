Rails.application.routes.draw do
  root 'pages#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  get '/users/auth/facebook/callback', to: 'pages#index'

  match '/settings', to: 'profiles#show', via: 'get'
  match '/settings', to: 'profiles#update', via: 'patch'

  resources :check_out_pages
  resources :books, :orders, :reviews
  resource :cart, only: [:show, :update]
  resources :order_items, only: [:create, :update, :destroy]
  resources :after_signup, only: [:show, :new, :create]
end

