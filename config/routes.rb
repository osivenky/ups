Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'dashboard#index'

  resources :ups, only: [] do
    collection do
      get 'connect'
      get 'callback'
    end
  end

  namespace :api do
    namespace :v1 do
      # resources :shipping, only: [:create]
      # resources :rates, only: [:index]
      # resources :tracking, only: [:show]

      resource :ups, only: [] do
        get :rates, to: "ups#rates"
        post :create_label, to: "ups#create_label"
        get :track, to: "ups#track"
      end
    end
  end
end
