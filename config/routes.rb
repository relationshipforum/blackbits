Rails.application.routes.draw do
  resources :forums
  resources :submissions, path: "threads" do
    resources :posts, only: [:create]

    member do
      get "unread"
    end
  end

  resources :posts do
    member do
      post "thanks"
    end
  end

  root to: "submissions#index"

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  get "members" => "users#index", as: :members
  get "users/:id" => "users#show", as: :user
end
