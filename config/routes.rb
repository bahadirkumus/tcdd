Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

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
  resources :profiles, only: [ :show, :edit, :update ] do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  # Posts
  resources :posts

  # StaticPages
  root "static_pages#home"
  get "about", to: "static_pages#about"
  get "help", to: "static_pages#help"
end
