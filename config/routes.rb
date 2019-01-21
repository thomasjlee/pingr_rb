Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index]

  resources :pings, only: [:index, :create, :update] do
    put :mark_all_as_read, on: :collection
  end

  get "/archives", to: "pings#archives"

  # Clearance routes
  resources :passwords,
    controller: 'clearance/passwords',
    only: [:create, :new]

  resource :session,
    controller: 'sessions',
    only: [:create]

  resources :users,
    controller: 'clearance/users',
    only: Clearance.configuration.user_actions do
      resource :password,
        controller: 'clearance/passwords',
        only: [:create, :edit, :update]
    end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'

  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'clearance/users#new', as: 'sign_up'
  end
end
