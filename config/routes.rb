Rails.application.routes.draw do
  get 'pages/index'

  devise_for :users
  resources :books
  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
