AnakinWebapp::Application.routes.draw do
  devise_for :users
  apipie

  resources :patterns
  resources :categories do
    resources :patterns
  end

  namespace :api_tests do
    resource :landscape
    resource :matching
    resource :histogram
    resource :ocr
  end

  namespace :users do
    resource :threescale, controller: 'threescale'
  end
  
  namespace :api do
    namespace :v1 do
      resources :categories
      namespace :patterns do
        resource :ocr
        resource :feature_matcher
        resource :histogram
        resource :landscape, controller: 'landscape'
      end
      resources :patterns do
        resources :scenarios
      end
      namespace :trainers do
        resource :matching
      end
    end
  end

  root to: "home#index"

end
