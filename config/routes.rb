Rails.application.routes.draw do
  
  get 'query_pages/index'
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    #sessions: 'users/sessions',
    #passwords: 'users/passwords',
    #registrations: 'users/registrations',
    #confirmations: 'users/confirmations',
    #unlocks: 'users/unlocks'
  }

  resources :users, except: [:index] do
    get 'following' => 'users#following'
    get 'followers' => 'users#followers'
  end

  root 'posts#index'
  
  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  
  get 'tags/:tag', to: 'posts#index', as: :tag
end
