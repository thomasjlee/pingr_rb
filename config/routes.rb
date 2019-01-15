Rails.application.routes.draw do
  root to: "users#index"
  resources :pings, only: [:index]
end
