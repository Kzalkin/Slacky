Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :channels, only: %i[index create show destroy]
      resources :messages, only: %i[index create]

      post 'auth', to: 'authentication#registration'
      post 'auth/sign_in', to: 'authentication#sign_in'
    end
  end
end
