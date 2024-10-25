Rails.application.routes.draw do
  root            "static_pages#home"
  get 'help' =>   "static_pages#help"
  get 'about' =>  "static_pages#about"
  resources :microposts
  resources :users

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  

  # # Re-enable resources :users but restrict to only the routes you need
  # resources :users, only: [:new, :create]
end
