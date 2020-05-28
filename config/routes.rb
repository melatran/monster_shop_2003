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

  delete "/logout", to: 'sessions#destroy'

  namespace :default_user do
    get "/profile", to: 'profile#index'
  end

  namespace :merchant do
    get '/dashboard', to: 'dashboard#index'
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

end
