Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      get :health, to: 'health#show'

      # User routes
      get 'users/current', to: 'users#show'
      patch 'users/current', to: 'users#update'
      delete 'users/current', to: 'users#destroy'

      # User profile routes
      get 'user_profiles/current', to: 'user_profiles#show'
      patch 'user_profiles/current', to: 'user_profiles#update'
      patch 'user_profiles/current/metadata', to: 'user_profiles#update_metadata'
      delete 'user_profiles/current/metadata/:key', to: 'user_profiles#delete_metadata'
    end
  end

  # Admin API routes
  namespace :admin do
    namespace :v1 do
      get :health, to: 'health#show'

      # User management routes
      resources :users do
        member do
          post :activate
        end

        collection do
          get :stats
        end
      end
    end
  end

  # Defines the root path route ("/")
  root "api/v1/health#show"
end
