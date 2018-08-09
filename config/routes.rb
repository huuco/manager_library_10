Rails.application.routes.draw do
  root "static_pages#home"
  
  devise_for :users

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
