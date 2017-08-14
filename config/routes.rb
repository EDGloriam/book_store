Rails.application.routes.draw do
  get 'profiles/show'

  get 'profiles/edit'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#index'
  get '/users/auth/facebook/callback', to: 'pages#index'
  get '/settings', to: 'users/users#edit'
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
# , controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
