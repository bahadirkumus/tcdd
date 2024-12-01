Rails.application.routes.draw do
  # Users AJAX
  resources :users, param: :username do
    collection do
      get "check_username"
      get "check_email"
    end
  end

  # Posts
  resources :posts

  # StaticPages
  root "static_pages#home"
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"

  # User Signup
  get "signup", to: "users#new"
  post "signup", to: "users#create"

  # User Profile
  resources :users, param: :username, only: [ :show, :edit, :update ]

  # Sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Additional routes
  get "up", to: "rails/health#show", as: :rails_health_check
end
