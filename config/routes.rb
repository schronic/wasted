Rails.application.routes.draw do

  get 'purchased_items/index'
  get 'purchased_items/show'
  get 'purchased_items/new'
  get 'purchased_items/create'
  get 'purchased_items/edit'
  get 'purchased_items/update'
  get 'purchased_items/destroy'
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'orders/create'
  get 'reservations/index'
  get 'reservations/show'
  get 'reservations/new'
  get 'reservations/create'
  get 'reservations/edit'
  get 'reservations/update'
  get 'reservations/destroy'
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

end
