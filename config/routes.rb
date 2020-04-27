require 'sidekiq/web'

Rails.application.routes.draw do
  root to: "articles#index"
  namespace :admin do
    resources :users
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :articles, except: [:show]
    resources :categories, except: [:show]
    resources :article_files
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
  resources :articles, only: :index
  resources :comments, only: [:create]
  get "pages/:slug", to: "articles#show", as: :article
  get "pages/:category_name/:slug", to: "articles#show", as: :category_article
  mount Sidekiq::Web, at: "/sidekiq"
  namespace :admin do
    get "*path", controller: "base", action: "render_404"
  end
  get "*path", controller: "application", action: "render_404"
end
