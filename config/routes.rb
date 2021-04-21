Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'home/index', as: 'home'
  resources :activities, only: [:index, :show]
  resources :trips
  resources :users, only: :show

  root 'home#index'
end
