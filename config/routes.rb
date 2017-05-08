Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items do 
    get :autocomplete_item_name, :on => :collection
  end 
  resources :purchases
  resources :item_prices

  # Added for Phase 5
  resources :users
  resources :sessions
  resources :orders
  resources :schools

  # get 'autocomplete_item' => 'items#autocomplete_item_name'
  
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
  
  get 'remove_from_shipping_list/:oi_id' => 'home#remove_from_shipping_list', :as => :remove_from_shipping_list
  get 'remove_from_reorder_list/:i_id' => 'home#remove_from_reorder_list', :as => :remove_from_reorder_list

  get 'boards' => 'home#boards', :as => :boards
  get 'clocks' => 'home#clocks', :as => :clocks
  get 'pieces' => 'home#pieces', :as => :pieces
  get 'supplies' => 'home#supplies', :as => :supplies

  get 'cart' => 'home#cart', :as => :cart



  # Set the root url
  root :to => 'home#home'  

end