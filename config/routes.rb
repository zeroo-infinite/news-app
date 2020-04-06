Rails.application.routes.draw do
  root to: "admins#index"
  resources :admins
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
