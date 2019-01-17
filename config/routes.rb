Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index]

  resources :pings, only: [:index] do
    get 'archives', on: :collection
  end
end
