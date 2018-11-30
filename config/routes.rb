Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  resources :items do
    resources :features, only: [:show, :index, :new, :create]
  end
  resources :purchases, only: %i[create new index show]

  get    '/home',             to: 'pages#home',           as: 'home'
  get    '/cart',             to: 'reservations#index',   as: 'cart'
  post   '/reservations',     to: 'reservations#create',  as: 'create_reservation'
  get    '/cart/:id',         to: 'reservations#show',    as: 'reservation'
  patch  '/cart/:id', to: 'reservations#update',  as: 'patch_reservation'
  delete '/cart/:id',         to: 'reservations#destroy', as: 'delete_reservation'

  resources :orders, only: [:new, :index, :show, :create, :destroy] do
    resources :payments, only: [:new, :create]
  end

  resources :users, only: [:show]

  resources :reservations, only: [:index]
  get '/reservations/error', to: 'reservations#error', as: 'reservations_error'

  post '/purchased_items', to: 'purchased_items#create', as: 'purchased_items_create'
  patch '/purchased_items', to: 'purchased_items#create', as: 'purchased_items_update'
  resources :purchased_items, except: [:create]

    namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items
    end
  end
end
