Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
      resources :comments
  end
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
