Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        resources :teas, only: [] do
          resources :subscriptions, only: [:create, :update]
        end
        resources :subscriptions, only: [:index], controller: "customers/subscriptions"
      end
    end
  end
end
