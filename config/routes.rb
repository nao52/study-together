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
    end
  end
  
  resources :posts
  resources :relationships, only: [:create, :destroy]
end
