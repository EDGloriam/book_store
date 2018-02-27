Rails.application.routes.draw do
  root 'pages#index'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  get '/users/auth/facebook/callback', to: 'pages#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  match '/settings', to: 'profiles#show', via: 'get'
  match '/settings', to: 'profiles#update', via: 'patch'

  resources :check_out_pages
  resources :books, :orders, :reviews
  resource :cart, only: [:show, :update]
  resources :order_items, only: [:create, :update, :destroy]
  resources :after_signup, only: [:show, :new, :create]
end

