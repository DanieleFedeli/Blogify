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

  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :users
  resources :posts do
    resources :comments
    resources :likes
  end
  
end
