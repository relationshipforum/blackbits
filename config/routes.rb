Rails.application.routes.draw do
  resources :forums
  resources :submissions, path: "threads" do
    resources :posts, only: [:create, :update, :destroy]
  end

  root to: "submissions#index"

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  get "users/:id" => "users#show", as: :user
  post "posts/:id/thanks" => "posts#thanks"
end
