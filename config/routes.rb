Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  # resources :merchants do
  #   resources :items, only: [:index, :new, :create]
  # end
  get "/merchants/:id/items", to: "items#index"
  get "/merchants/:id/items/new", to: "items#new"
  post "/merchants/:id/items", to: "items#create"

  # resources :items, only: [:index, :show, :edit, :destroy, :update]
  get "/items", to: "items#index"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/items/:id", to: "items#show"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  # resources :reviews, only: [:edit, :update, :destroy]
  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :show, :create]
  # get "/orders/new", to: 'orders#new'
  # get "/orders/:id", to: 'orders#show'
  # post "/orders", to: 'orders#create'

  # resources :register do
  #   resources :users, only: [:new, :create]
  # end
  get "/register", to: "users#new"
  post "/register", to: 'users#create'

  post "/users", to: "users#create"

  get "/login", to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get "/logout", to: 'sessions#destroy'
  delete "/logout", to: 'sessions#destroy'

  namespace :default_user do
    get "/profile", to: 'profile#index'
    get "/profile/edit", to: 'profile#edit'
    patch "/profile", to: 'profile#update'
    get "/profile/orders", to: 'orders#index'
    get "/profile/orders/:order_id", to: 'orders#show'
    get "/cart", to: 'cart#show'
    get "/cancel", to: 'orders#update'
    patch "/profile/orders/:id", to: 'orders#update'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    get '/items', to: 'merchant_items#index'
    delete '/items/:id', to: 'merchant_items#destroy'
    get '/items/new', to: 'merchant_items#new'
    post '/items', to: 'merchant_items#create'
    patch '/items', to: 'merchant_items#update'
    get '/items/:item_id', to: 'merchant_items#edit'
    patch '/items/:item_id', to: 'merchant_items#update'
    get '/orders', to: 'orders#index'
    get '/orders/:id', to: 'orders#show'
    patch '/orders/:id', to: 'orders#update'
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    get '/merchants/:id', to: 'merchants#show'
    get '/merchants', to: 'merchants#index'
    patch '/merchants/:id', to: 'merchants#update'
    get '/orders', to: 'orders#update'
    get '/merchants', to: 'merchants#index'
    patch '/merchants/:id', to: 'merchants#update'
    get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#edit'
    get '/merchants/:id/items', to: 'merchant_items#index'
    patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    get '/users/:id/orders', to: 'orders#show'
  end
end
