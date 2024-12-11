Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  # Users AJAX
  resources :users, param: :username, controller: "users/users", only: [:show, :edit, :update] do
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
  resources :profiles, param: :username, controller: "profiles", only: [:show, :edit, :update] do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  # Movements
  resources :movements, only: [:index, :new, :create]

  # Static Pages
  root "movements#index"
  get "about", to: "static_pages#about"
  get "terms_of_service", to: "static_pages#terms_of_service"
  get "privacy_policy", to: "static_pages#privacy_policy"
  get "cookies_policy", to: "static_pages#cookies_policy"
end
