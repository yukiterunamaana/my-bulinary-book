Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :ingredients, only: [:create, :destroy]
  end

  get "/sign_up", to: "sessions#sign_up", as: :sign_up
  post "/sessions", to: "sessions#create", as: :sessions
  get "/sign_in", to: "sessions#sign_in", as: :sign_in
  post "/sessions/login", to: "sessions#login", as: :sessions_login
  delete "/sign_out", to: "sessions#sign_out", as: :sign_out
end
