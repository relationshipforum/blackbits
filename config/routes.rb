Rails.application.routes.draw do
  resources :chats do
    collection { get "socket" }
  end

  resources :conversations
  resources :forums, only: [:index]
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

  devise_for :users,  path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
                      controllers: { sessions: "sessions" }

  authenticated :user do
    root to: "users#root", as: :authenticated_root
  end

  unauthenticated do
    root to: "forums#index"
  end

  get "members" => "users#index", as: :members
  resources :users

  get "profile" => "profile#edit"
  get "profile/avatar" => "profile#avatar"
  get "profile/settings" => "profile#settings"
  get "profile/signature" => "profile#signature"

  get "forums/:forum_id" => "submissions#index", as: :forum
end
