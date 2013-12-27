AnakinWebapp::Application.routes.draw do
  get "api_tests/show"
  devise_for :users
  apipie

  resources :patterns
  resource :api_test
  
  namespace :api do
    namespace :v1 do
      namespace :patterns do
        resource :feature_matcher
      end
      resources :patterns do
        resources :scenarios
      end
    end
  end

  root to: "home#index"

end
