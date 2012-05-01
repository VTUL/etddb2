NewVtEtdUpgrd::Application.routes.draw do
  # These are boring static pages.
  root :to => 'pages#home'
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/authorhelp', :to => 'pages#authorhelp'
  match '/staffhelp', :to => 'pages#staffhelp'
  match '/dev', :to => 'pages#dev'

  # Set up devise for people, and make it use our sessions controller.
  devise_for :people, :controllers => {:sessions => "people/sessions"}
  post '/people/:id/delete', :to => 'devise/registrations#destroy', :as => :destroy_person

  # devise_scope takes the singular model name, and devise_for takes the plural. Why?
  # Also note: route to our sessions controller rather than the devise one.
  devise_scope :person do
    get "login", :to => "people/sessions#new"
    post "login", :to => "people/sessions#create"
    get "logout", :to => "people/sessions#destroy"
  end

  resources :people, :only => [:index, :show]
  post '/people/find', :to => 'people#find'
  post '/people/new_committee_member', :to => 'people#new_committee_member'
  post '/people/add_committee', :to => 'people#add_committee'

  resources :etds, :except => :destroy
  post '/etds/:id/delete', :to => 'etds#destroy', :as => :destroy_etd
  get '/etds/my_etds', :to => 'etds#my_etds', :as => :my_etds
  get '/etds/next_new/:id', :to => 'etds#next_new', :as => :next_new_etd
  put '/etds/next_new/:id', :to => 'etds#save_contents', :as => :save_contents_to_etd
  get '/etds/add_contents/:id', :to => 'etds#add_contents', :as => :add_contents_to_etd
  post '/etds/submit/:id', :to => 'etds#submit', :as => :submit_etd

  resources :contents, :except => [:new, :create, :destroy]
  post '/contents/:id/delete', :to => 'contents#destroy', :as => :destroy_content
  get '/contents/my_contents', :to => 'contents#my_contents', :as => :my_contents
  post '/contents/new', :to => 'contents#new', :as => :new_content
  put '/contents', :to => 'contents#create'

  resources :degrees, :except => :destroy
  post '/degrees/:id/delete', :to => 'degrees#destroy', :as => :destroy_degree
  resources :departments, :except => :destroy
  post '/departments/:id/delete', :to => 'departments#destroy', :as => :destroy_deparmtent
  resources :provenances, :except => :destroy
  post '/provenances/:id/delete', :to => 'provenances#destroy', :as => :destroy_provenance
  resources :availabilities, :except => :destroy
  post '/availabilities/:id/delete', :to => 'availabilities#destroy', :as => :destroy_availability
  resources :document_types, :except => :destroy
  post '/document_types/:id/delete', :to => 'document_types#destroy', :as => :destroy_document_type
  resources :privacy_statements, :except => :destroy
  post '/privacy_statements/:id/delete', :to => 'privacy_statements#destroy', :as => :destroy_privacy_statement
  resources :copyright_statements, :except => :destroy
  post '/copyright_statements/:id/delete', :to => 'copyright_statements#destroy', :as => :destroy_copyright_statement

  resources :roles, :except => :destroy
  post '/roles/:id/delete', :to => 'roles#destroy', :as => :destroy_role
  resources :people_roles, :except => :destroy
  post '/people_roles/:id/delete', :to => 'people_roles#destroy', :as => :destroy_people_role

  resources :user_actions, :except => :destroy
  post '/user_actions/:id/delete', :to => 'user_actions#destroy', :as => :destroy_user_action
  resources :digital_objects, :except => :destroy
  post '/digital_objects/:id/delete', :to => 'digital_objects#destroy', :as => :destroy_digital_object
  resources :permissions, :only => [:index, :edit, :update]

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end
