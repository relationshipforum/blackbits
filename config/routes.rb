Rails.application.routes.draw do
  resources :chats do
    collection { get "socket" }
  end

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

  devise_for :users,  path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
                      controllers: { sessions: "sessions" }
  get "members" => "users#index", as: :members
  resources :users

  get "profile" => "profile#edit"
  get "profile/avatar" => "profile#avatar"
  get "profile/settings" => "profile#settings"
  get "profile/signature" => "profile#signature"
end
