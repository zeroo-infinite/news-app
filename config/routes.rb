require 'sidekiq/web'

Rails.application.routes.draw do
  root to: "home#index"
  namespace :admin do
    get "/", to: "home#index"
    resources :users
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :articles
    resources :categories, except: [:show]
    resources :article_files
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
  resources :articles, only: :index
  namespace :ranking do
    get "pv", to: "articles#pv"
    get "pv/:category_name", to: "articles#pv"
    get "comment", to: "articles#comment"
    get "comment/:category_name", to: "articles#comment"
  end
  resources :comments, only: [:create]
  get "pages/:slug", to: "articles#show", as: :article
  get "pages/:category_name/:slug", to: "articles#show", as: :category_article
  mount Sidekiq::Web, at: "/sidekiq"
  namespace :admin do
    get "*path", controller: "base", action: "render_404"
  end
  get "*path", controller: "application", action: "render_404"
end
