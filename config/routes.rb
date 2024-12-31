Rails.application.routes.draw do
  get "search/results"
  resources :vibes
  get "chat_users/create"
  get "messages/create"
  get "chats/index"

  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", confirmations: "users/confirmations" }

  # Verifications
  resources :verifications, only: [:new, :create]

  # Users AJAX
  resources :users, param: :username, controller: "users/users", only: [ :show, :edit, :update ] do
    member do
      post "follow", to: "follows#create", as: "follow"
      delete "unfollow", to: "follows#destroy", as: "unfollow"
    end
    collection do
      get "check_username"
      get "check_email"
    end
  end

  #Search
  get 'search', to: 'search#results', as: 'search'
  resources :users, only: [:index]

  # Profiles
  resources :profiles, only: [:show, :edit, :update], param: :username do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  # Movements
  resources :movements do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # Vibes
  resources :vibes do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # Chats
  resources :chats do
    resources :messages, param: :chat_id
    collection do
      get "private/:other_user_id", to: "chats#private_chat", as: "private_chat"
    end
  end

  # Folks
  resources :folks do
    member do
      post :join
      delete :leave
    end
  end
  
  

  # StaticPages
  root "static_pages#index"
  get "about", to: "static_pages#about"
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "cookies_policy", to: "static_pages#cookies_policy"
end
