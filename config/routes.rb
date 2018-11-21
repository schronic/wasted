Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users

  resources :items
  resources :purchases, only: %i[create new index show]

  get    '/cart',          to: 'reservations#index',  as: 'cart'
  post   '/cart',          to: 'reservations#create', as: 'create_reservation'
  get    '/cart/:id',      to: 'reservations#show',   as: 'reservation'
  patch  '/cart/:id',      to: 'reservations#update'
  delete '/cart/:id',      to: 'reservations#destroy',as: 'delete_reservation'

  resources :orders, only: [:new, :index, :show, :create] do
    resources :payments, only: [:new, :create]
  end

  resources :reservations, only: [:index]
  get '/reservations/error', to: 'reservations#error', as: 'reservations_error'

  resources :purchased_items

end
