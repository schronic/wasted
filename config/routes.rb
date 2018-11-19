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
end
