Rails.application.routes.draw do
  root "static_pages#home"
  
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  get "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"
  delete "log_out", to: "sessions#destroy"
  
  resources :books, only: [:show] do
    resources :comments, only: %i(create update destroy)
    resources :likes, only: %i(create destroy)
    resources :borrows, except: %i(index)
  end

  namespace :admin do
    root "users#index"
    resources :users, :authors, :categories, :publishers
    resources :books do
      resources :comments, only: %i(create update destroy)
      resources :likes, only: %i(create destroy)
      resources :borrows
    end
  end
end
