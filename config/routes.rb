Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, only: [:index, :show, :edit, :destroy, :update]

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  resources :reviews, only: [:edit, :update, :destroy]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :create, :show]

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
    get "/profile/orders/:id", to: 'orders#show'
  end

  namespace :merchant do
    get '/dashboard', to: 'dashboard#index'
    get '/items', to: 'merchant_items#index'
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

end
