# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :trips do
    get "posts", to: "posts#index_trip", as: :posts
    get "posts/new", to: "posts#new_trip", as: :new_post
    get "media_items", to: "media_items#index_trip", as: :media_items
    get "media_items/new", to: "media_items#new_trip", as: :new_media_item
    put "set_cover_photo/:media_item_id", to: "trips#set_cover_photo", as: :set_cover_photo

    post :like, to: "trips/likes#create"
    delete :like, to: "trips/likes#destroy"

    resources :comments, module: :trips
    resources :trip_users

    resources :segments do
      put "increase_sequence", to: "segments#increase_sequence", as: :increase_sequence
      put "decrease_sequence", to: "segments#decrease_sequence", as: :decrease_sequence
    end

    resources :waypoints do
      get "media_items", to: "media_items#index_waypoint", as: :media_items
      get "media_items/new", to: "media_items#new_waypoint", as: :new_media_item
      get "posts", to: "posts#index_waypoint", as: :posts
      get "posts/new", to: "posts#new_waypoint", as: :new_post
      put "increase_sequence", to: "waypoints#increase_sequence", as: :increase_sequence
      put "decrease_sequence", to: "waypoints#decrease_sequence", as: :decrease_sequence
    end
  end

  get "waypoints/search/:keyword", to: "waypoints#search", as: :waypoints_search
  get "waypoints/distance/:id_from/:id_to", to: "waypoints#distance", as: :waypoints_distance

  resources :activities, only: %i[index show] do
    resources :comments, module: :activities
    post :like, to: "activities/likes#create"
    delete :like, to: "activities/likes#destroy"
  end

  resources :posts, except: :index do
    resources :comments, module: :posts
    post :like, to: "posts/likes#create"
    delete :like, to: "posts/likes#destroy"
  end

  resources :media_items, except: :index do
    resources :comments, module: :media_items
    post :like, to: "media_items/likes#create"
    delete :like, to: "media_items/likes#destroy"
  end

  resources :users, only: :show do
    post "follow", to: "users#follow", as: :follow
    delete "unfollow", to: "users#unfollow", as: :unfollow
  end

  resources :comments, only: %i[update edit destroy] do
    post :like, to: "comments/likes#create"
    delete :like, to: "comments/likes#destroy"
  end

  get "home/index", as: :home
  get "summary/overall", as: :summary_overall
  get "summary/current_year", as: :summary_current_year
  get "summary/last_year", as: :summary_last_year

  get "media_items_public", to: "media_items#index_public", as: :media_items_public
  get "posts_public", to: "posts#index_public", as: :posts_public
  get "trips_public", to: "trips#index_public", as: :trips_public

  root "home#index"
end
