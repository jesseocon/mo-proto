MoProto::Application.routes.draw do
  
  get 'home',       to: "static_pages#home",  as: 'home'
  get 'help',       to: "static_pages#help",  as: 'help'
  get 'about',      to: "static_pages#about", as: 'about'

  get 'signup',     to: 'users#new',          as: 'signup'
  get 'login',      to: 'sessions#new',       as: 'login'
  delete 'logout',  to: 'sessions#destroy',   as: 'logout'
  
  get 'callbacks',       to: 'google_contacts#callbacks',     as: 'callbacks'
  get 'get_client',      to: 'google_contacts#get_client',    as: 'get_client'
  get 'get_contacts',    to: 'google_contacts#get_contacts',  as: 'get_contacts'
  
  root to: "static_pages#home"
  resource :inbox, :controller => 'inbox', :only => [:show,:create]
  resources :albums do 
    member do 
      get 'get_pics'
    end
    member do 
      get 'get_html_pics'
    end
    member do 
      get 'invite'
    end
    member do
      get 'sync_gmail'
    end
  end
  resources :messages
  resources :password_resets
  resources :folios do
    collection do 
      get 'check_availability'
      get 'register_keyword'
      get 'deregister_keyword'
      get 'confirmation'
    end
  end
  resources :images
  resources :sessions
  resources :stars
  resources :users
  resources :verifications
  resources :packages
  resources :charges
  resources :google_contacts
  resources :invitations
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
