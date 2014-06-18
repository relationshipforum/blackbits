Rails.application.routes.draw do
  resources :submissions, as: "threads"

  root to: "home#index"

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
end
