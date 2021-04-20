Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'home/index', as: 'home'
  get 'activities/index', as: 'activities'

  root 'home#index'
end
