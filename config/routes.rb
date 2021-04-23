Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'home/index', as: 'home'

  resources :activities, only: %i[index show]
  post 'activities/:id/like', to: 'activities#like', as: :like_activity
  delete 'activities/:id/like', to: 'activities#dislike', as: :dislike_activity
  get 'activities/:id/comments', to: 'comments#index_activity', as: :activity_comments
  get 'activities/:id/comments/new', to: 'comments#new_activity', as: :activity_new_comment
  post 'activities/:id/comments', to: 'comments#create'

  resources :trips do
    get 'posts', to: 'posts#index_trip', as: :posts
    get 'posts/new', to: 'posts#new_trip', as: :new_post
    get 'comments', to: 'comments#index_trip', as: :comments
    get 'comments/new', to: 'comments#new_trip', as: :new_comment
    post 'comments', to: 'comments#create'

    resources :segments
    resources :waypoints do
      get 'posts', to: 'posts#index_waypoint', as: :posts
      get 'posts/new', to: 'posts#new_waypoint', as: :new_post
    end
  end

  resources :posts
  post 'posts/:id/like', to: 'posts#like', as: :like_post
  delete 'posts/:id/like', to: 'posts#dislike', as: :dislike_post
  get 'posts/:id/comments', to: 'comments#index_post', as: :post_comments
  get 'posts/:id/comments/new', to: 'comments#new_post', as: :post_new_comment
  post 'posts/:id/comments', to: 'comments#create'

  resources :comment, only: %i[edit delete]
  post 'comments/:id/like', to: 'comments#like', as: :like_comment
  delete 'comments/:id/like', to: 'comments#dislike', as: :dislike_comment

  resources :users, only: :show

  root 'home#index'
end
