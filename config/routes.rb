Rails.application.routes.draw do
  root "static_pages#home"
  
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  get "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"
  delete "log_out", to: "sessions#destroy"
  
  resources :users, only: [:show]
  resources :categories, :authors, :publishers, only: %i(index show)
  resources :books, only: [:show, :index] do
    resources :comments, only: %i(create update destroy)
    resources :likes, :follows, only: %i(create destroy)
    resources :borrows, except: %i(index destroy)
  end

  namespace :admin do
    root "borrows#index"
    resources :users, :authors, :categories, :publishers, :borrows
    resources :books do
      resources :comments, only: %i(create update destroy)
      resources :likes, :follows, only: %i(create destroy)
      resources :borrows
    end
  end
end
