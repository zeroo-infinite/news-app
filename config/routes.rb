Rails.application.routes.draw do
  root to: "admin/users#index"
  namespace :admin do
    resources :users
    resources :articles, except: [:show]
    resources :categories, except: [:show]
    resources :article_files
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
  resources :articles, only: :index
  get "pages/:slug", to: "articles#show", as: :article
  get "pages/:category_name/:slug", to: "articles#show", as: :category_article
end
