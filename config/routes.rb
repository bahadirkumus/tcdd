Rails.application.routes.draw do
  get "sessions/new"
  # Users
  resources :users, param: :username do
    collection do
      get "check_username"
      get "check_email"
    end
  end

  # StaticPages
  root "static_pages#home"
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "up", to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # API
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
    end
  end
end
