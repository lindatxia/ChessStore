Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices

  # Added for Phase 5
  resources :users
  resources :sessions
  resources :orders
  

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  # Added for Phase 5
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'add_to_cart/:item_id' => 'orders#add_to_cart', :as => :add_to_cart
  get 'remove_from_cart/:item_id' => 'orders#remove_from_cart', :as => :remove_from_cart

  get 'boards' => 'home#boards', :as => :boards
  get 'clocks' => 'home#clocks', :as => :clocks
  get 'pieces' => 'home#pieces', :as => :pieces
  get 'supplies' => 'home#supplies', :as => :supplies

  # Set the root url
  root :to => 'home#home'  

end