Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  
  resources :users do
    resources :pending_posts
  end

  resources :pending_posts do
    get 'accept' => 'pending_posts#accept'
  end
  
  
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :posts do
    resources :comments
  end
  
end
