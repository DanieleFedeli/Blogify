Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  
  resources :pending_posts do
    get 'accept' => 'pending_posts#accept'
  end
  
  resources :users do
    resources :pending_posts
    resources :posts do
      resources :comments
    end
  end
  
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts do
    resources :comments
  end
  
end
