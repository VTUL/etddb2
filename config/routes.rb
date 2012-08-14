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

  post '/people/find', :to => 'people#find'
  post '/people/new_committee_member', :to => 'people#new_committee_member'
  post '/people/add_committee', :to => 'people#add_committee'
  get '/people/new_legacy', :to => 'people#new', :as => :new_legacy_person
  get '/people/edit_legacy/:id', :to => 'people#edit', :as => :edit_legacy_person
  post '/people/new_legacy', :to => 'people#create', :as => :create_legacy_person
  put '/people/edit_legacy/:id', :to => 'people#update', :as => :update_legacy_person
  post '/people/destroy_legacy/:id', :to => 'people#destroy', :as => :destroy_legacy_person
  resources :people, :only => [:index, :show]

  post '/etds/:id/delete', :to => 'etds#destroy', :as => :destroy_etd
  get '/etds/next_new/:id', :to => 'etds#next_new', :as => :next_new_etd
  put '/etds/next_new/:id', :to => 'etds#save_contents', :as => :save_contents_to_etd
  get '/etds/add_contents/:id', :to => 'etds#add_contents', :as => :add_contents_to_etd
  post '/etds/submit/:id', :to => 'etds#submit', :as => :submit_etd
  post '/etds/vote/:id', :to => 'etds#vote', :as => :vote_for_etd
  post '/etds/unsubmit/:id', :to => 'etds#unsubmit', :as => :unsubmit_etd
  get '/etds/reviewboard/:id', :to => 'etds#reviewboard', :as => :etd_reviewboard
  resources :etds, :except => :destroy

  post '/contents/:id/delete', :to => 'contents#destroy', :as => :destroy_content
  post '/contents/new', :to => 'contents#new', :as => :new_content
  post '/contents', :to => 'contents#create'
  resources :contents, :except => [:new, :create, :destroy]

  post '/degrees/:id/delete', :to => 'degrees#destroy', :as => :destroy_degree
  resources :degrees, :except => :destroy
  post '/departments/:id/delete', :to => 'departments#destroy', :as => :destroy_department
  resources :departments, :except => :destroy
  post '/provenances/:id/delete', :to => 'provenances#destroy', :as => :destroy_provenance
  resources :provenances, :except => :destroy
  post '/availabilities/:id/delete', :to => 'availabilities#destroy', :as => :destroy_availability
  resources :availabilities, :except => :destroy
  post '/document_types/:id/delete', :to => 'document_types#destroy', :as => :destroy_document_type
  resources :document_types, :except => :destroy
  post '/privacy_statements/:id/delete', :to => 'privacy_statements#destroy', :as => :destroy_privacy_statement
  resources :privacy_statements, :except => :destroy
  post '/copyright_statements/:id/delete', :to => 'copyright_statements#destroy', :as => :destroy_copyright_statement
  resources :copyright_statements, :except => :destroy

  post '/roles/:id/delete', :to => 'roles#destroy', :as => :destroy_role
  resources :roles, :except => :destroy
  post '/people_roles/:id/delete', :to => 'people_roles#destroy', :as => :destroy_people_role
  resources :people_roles, :except => :destroy

  post '/user_actions/:id/delete', :to => 'user_actions#destroy', :as => :destroy_user_action
  resources :user_actions, :except => :destroy
  post '/digital_objects/:id/delete', :to => 'digital_objects#destroy', :as => :destroy_digital_object
  resources :digital_objects, :except => :destroy
  get '/permissions', :to => 'permissions#index', :as => :permissions
  get '/permissions/edit', :to => 'permissions#edit', :as => :edit_permissions
  post '/permissions/edit', :to => 'permissions#update', :as => :update_permissions

  post '/messages/:id/delete', :to => 'messages#destroy', :as => :destroy_message
  resources :messages, :except => :destroy
  post '/conversations/:id/delete', :to => 'conversations#destroy', :as => :destroy_conversation
  resources :conversations, :except => :destroy

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end
