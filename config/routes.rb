Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  resources :microposts
  resources :users

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static_pages#home"

  # # Re-enable resources :users but restrict to only the routes you need
  # resources :users, only: [:new, :create]
end
