Rails.application.routes.draw do
  resources :chats do
    collection do
      get "socket"
      get "load"
    end
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
      get "redirect"
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

  get "about" => "pages#about"
  get "rules" => "pages#rules"
  get "members" => "users#index", as: :members

  resources :users do
    member do
      delete "spammer"
    end
  end

  get "profile" => "profile#edit"
  get "profile/avatar" => "profile#avatar"
  get "profile/settings" => "profile#settings"
  get "profile/signature" => "profile#signature"

  get "forums/:forum_id" => "submissions#index", as: :forum

  get "search" => "search#index"
  post "search" => "search#index"
end
