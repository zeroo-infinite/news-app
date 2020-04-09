Rails.application.routes.draw do
  root to: "admins#index"
  namespace :admin do
    resources :users
    resources :articles, except: [:index, :show]
    resources :categories, except: [:show]
  end
  resources :articles, only: :index
  get "pages/:slug", to: "articles#show", as: :article
  get "pages/:category_name/:slug", to: "articles#show", as: :category_article
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
