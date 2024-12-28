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

  # Movements
  resources :movements, only: [:index, :new, :create, :edit, :update, :destroy]

  # Chats
  resources :chats do
    resources :messages, param: :chat_id
    collection do
      get "private/:other_user_id", to: "chats#private_chat", as: "private_chat"
    end
  end

  # StaticPages
  root "static_pages#index"
  get "about", to: "static_pages#about"
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "cookies_policy", to: "static_pages#cookies_policy"
end
