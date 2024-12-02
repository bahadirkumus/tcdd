Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  # Users AJAX
  resources :users, param: :username, controller: "users/users" do
    collection do
      get "check_username"
      get "check_email"
    end

    member do
      get "edit_username"
      patch "update_username"
      get "edit_email"
      patch "update_email"
      get "edit_password"
      patch "update_password"
      patch "update_avatar"
      patch "update_bio"
      patch "update_location"
    end
  end

  # Posts
  resources :posts

  # StaticPages
  root "static_pages#home"
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"

  # Additional routes
  get "up", to: "rails/health#show", as: :rails_health_check
end
