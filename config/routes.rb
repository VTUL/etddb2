NewVtEtdUpgrd::Application.routes.draw do

  get "pages/home"
  get "pages/about"
  get "pages/contact"
  get "pages/help"
  get "pages/dev"

  root :to => 'pages#home'
  match '/about',   :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/help',    :to => 'pages#help'
  match '/dev',     :to => 'pages#dev'

  #match '/signup',  :to => 'people#new'

  resources :etds
  resources :people
  resources :roles

  resources :urns
  resources :departments
  resources :doc_type_descriptions
  resources :degree_descriptions
  resources :permissions
  resources :person_roles
  resources :actions
  resources :digital_objects
  resources :provenances
  resources :availability_descriptions
  resources :copyright_statements
  resources :keywords
  resources :contents
  #resources :sessions, :only => [:new, :create, :destroy]

  #get "sessions#new"
  #match '/login',   :to => 'sessions#new'
  #match '/logout',  :to => 'sessions#destroy'

  #get 'browse/index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  # COMMENT REMOVE 2 Lines below for address to work /sessions/new/
  match 'submit/login' => 'sessions#new'
  #match 'submit/create' => 'sessions#create'


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  #match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
