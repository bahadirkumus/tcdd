Rails.application.routes.draw do
  get "chat_users/create"
  get "messages/create"
  get "chats/index"
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", confirmations: "users/confirmations" }

  # Users AJAX
  resources :users, param: :username, controller: "users/users", only: [ :show, :edit, :update ] do
    member do
      get :edit_user
      patch :update_user
    end
    collection do
      get "check_username"
      get "check_email"
    end
  end

  # Profiles
  resources :profiles, param: :username, controller: "profiles", only: [ :show, :edit, :update ] do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  # Posts
  resources :posts

  # Chats
  resources :chats do
    resources :messages, param: :chat_id
  end

  # StaticPages
  root "static_pages#home"
  get "about", to: "static_pages#about"
  get "help", to: "static_pages#help"
end
