Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index]

  resources :pings, only: [:index, :create, :update] do
    put :mark_all_as_read, on: :collection
  end

  get "/archives", to: "pings#archives"
end
