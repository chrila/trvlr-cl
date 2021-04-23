Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'home/index', as: 'home'

  resources :activities, only: [:index, :show]
  post 'activities/:id/like', to: 'activities#like', as: :like_activity
  delete 'activities/:id/like', to: 'activities#dislike', as: :dislike_activity

  resources :trips do
    get 'posts', to: 'posts#index_trip', as: :posts
    get 'posts/new', to: 'posts#new_trip', as: :new_post
    resources :segments
    resources :waypoints do
      get 'posts', to: 'posts#index_waypoint', as: :posts
      get 'posts/new', to: 'posts#new_waypoint', as: :new_post
    end
  end

  resources :posts
  post 'posts/:id/like', to: 'posts#like', as: :like_post
  delete 'posts/:id/like', to: 'posts#dislike', as: :dislike_post

  resources :users, only: :show

  root 'home#index'
end
