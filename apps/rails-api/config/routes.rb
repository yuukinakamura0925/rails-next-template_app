Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      get :health, to: 'health#show'
      # Future API endpoints will be added here
    end
  end
  
  # Admin API routes
  namespace :admin do
    namespace :v1 do
      get :health, to: 'health#show'
      # Future admin API endpoints will be added here
    end
  end

  # Defines the root path route ("/")
  root "api/v1/health#show"
end
