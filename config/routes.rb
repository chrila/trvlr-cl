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
    resources :waypoints
    resources :segments
  end

  resources :users, only: :show

  root 'home#index'
end
