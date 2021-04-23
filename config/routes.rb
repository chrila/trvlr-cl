Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'home/index', as: 'home'

  resources :activities, only: %i[index show]
  scope 'activities/:id', as: :activity do
    post 'like', to: 'activities#like', as: :like
    delete 'like', to: 'activities#dislike', as: :dislike
    get 'comments', to: 'comments#index_activity', as: :comments
    get 'comments/new', to: 'comments#new_activity', as: :new_comment
    post 'comments', to: 'comments#create'
  end

  resources :trips do
    get 'posts', to: 'posts#index_trip', as: :posts
    get 'posts/new', to: 'posts#new_trip', as: :new_post

    resources :segments
    resources :waypoints do
      get 'posts', to: 'posts#index_waypoint', as: :posts
      get 'posts/new', to: 'posts#new_waypoint', as: :new_post
    end
  end

  scope 'trips/:id', as: :trip do
    post 'like', to: 'trips#like', as: :like
    delete 'like', to: 'trips#dislike', as: :dislike
    get 'comments', to: 'comments#index_trip', as: :comments
    get 'comments/new', to: 'comments#new_trip', as: :new_comment
    post 'comments', to: 'comments#create'
  end

  resources :posts
  scope 'posts/:id', as: :post do
    post 'like', to: 'posts#like', as: :like
    delete 'like', to: 'posts#dislike', as: :dislike
    get 'comments', to: 'comments#index_post', as: :comments
    get 'comments/new', to: 'comments#new_post', as: :new_comment
    post 'comments', to: 'comments#create'
  end

  resources :comments, only: %i[edit delete]
  scope 'comments/:id', as: :comment do
    post 'like', to: 'comments#like', as: :like
    delete 'like', to: 'comments#dislike', as: :dislike
  end

  resources :users, only: :show

  root 'home#index'
end
