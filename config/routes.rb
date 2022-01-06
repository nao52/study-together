Rails.application.routes.draw do
  root to: 'posts#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'toppage', to: 'toppages#index'
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
      get :joinings
    end
  end
  
  resources :groups do
    member do
      get :joineds
      resources :group_posts, only: [:create, :edit, :destroy]
    end
  end
  
  resources :posts
  resources :group_posts, only: [:new]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :group_users, only: [:create, :destroy]
end
