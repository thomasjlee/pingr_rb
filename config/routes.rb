Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index]

  resources :pings, only: [:index, :create]

  get "/archives", to: "pings#archives"
end
