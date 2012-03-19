NewVtEtdUpgrd::Application.routes.draw do
  # Set up devise for people, and make it use our sessions controller.
  devise_for :people, :controllers => {:sessions => "people/sessions"}

  # devise_scope takes the singular model name, and devise_for takes the plural. Why?
  # Also note: route to our sessions controller rather than the devise one.
  devise_scope :person do
    get "login", :to => "people/sessions#new"
    post "login", :to => "people/sessions#create"
    get "logout", :to => "people/sessions#destroy"
  end

  root :to => 'pages#home'
  match '/about',     :to => 'pages#about'
  match '/contact',   :to => 'pages#contact'
  match '/authorhelp',:to => 'pages#authorhelp'
  match '/staffhelp', :to => 'pages#staffhelp'
  match '/dev',       :to => 'pages#dev'

  get '/etds/my_etds' => 'etds#my_etds', :as => :my_etds
  get '/etds/next_new/:id' => 'etds#next_new', :as => :next_new_etd
  put '/etds/next_new/:id' => 'etds#save_contents'
  get '/etds/add_contents/:id' => 'etds#add_contents', :as => :add_contents_to_etd

  get '/contents/my_contents' => 'contents#my_contents'
  post '/contents/new' => 'contents#new' # Need to post the ETD ID to this route.
  put '/contents' => 'contents#create' # Should accept files upon creation.

  match '/people/find' => 'people#find'
  match '/people/new_committee_member' => 'people#new_committee_member'
  match '/people/add_committee' => 'people#add_committee'

  resources :etds
  resources :roles
  resources :people
  resources :degrees
  resources :contents
  resources :departments
  resources :provenances
  resources :document_types
  resources :availabilities
  resources :privacy_statements
  resources :copyright_statements
  resources :user_actions
  resources :digital_objects
  get '/permissions/' => 'permissions#index'
  get '/permissions/edit' => 'permissions#edit'
  post '/permissions/edit' => 'permissions#update'
  resources :people_roles

  #get 'browse/index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  # COMMENT REMOVE 2 Lines below for address to work /sessions/new/
  #match 'sessions/new' => 'submit#login'
  #match 'submit/create' => 'sessions#create'
  #match 'submit/login' => 'sessions#new'
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
  #match ':controller(/:action(/:id(.:format)))'
end
