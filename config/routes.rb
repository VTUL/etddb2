NewVtEtdUpgrd::Application.routes.draw do
  class UrnConstraint
    def matches?(request)
      !/etd-\d+(-\d+)?/.match(request.params[:urn]).nil?
    end
  end

  require 'resque/server'
  require 'resque_scheduler/server'

  # These are boring static pages.
  root :to => 'pages#home'

  get '/about', :to => 'pages#about'
  get '/contact', :to => 'pages#contact'
  get '/authorhelp', :to => 'pages#authorhelp'
  get '/staffhelp', :to => 'pages#staffhelp'
  get '/dev', :to => 'pages#dev'
  get '/survey_return', :to => 'pages#survey_return', :as => :survey_return

  # Set up devise for people, and make it use our sessions controller.
  devise_for :people, :controllers => {:sessions => "people/sessions"}
  post '/people/:id/delete', :to => 'devise/registrations#destroy', :as => :destroy_person

  # devise_scope takes the singular model name, and devise_for takes the plural. Why?
  # Also note: route to our sessions controller rather than the devise one.
  devise_scope :person do
    get "/login", :to => "people/sessions#new"
    post "/login", :to => "people/sessions#create"
    get "/logout", :to => "people/sessions#destroy"
  end

  get '/people/new_legacy', :to => 'people#new', :as => :new_legacy_person
  get '/people/:id/edit_legacy', :to => 'people#edit', :as => :edit_legacy_person
  post '/people/new_legacy', :to => 'people#create', :as => :create_legacy_person
  put '/people/:id/edit_legacy', :to => 'people#update', :as => :update_legacy_person
  post '/people/:id/destroy_legacy', :to => 'people#destroy', :as => :destroy_legacy_person
  resources :people, :only => [:index, :show]
  # This allows us to link to an attached model, and not get errors with LegacyPeople.
  # However, this route never needs to resolve, it is absorbed by the resources route above it. It just needs to be named.
  get '/people/:id', :to => 'people#show', :as => :legacy_person

  post '/etds/:id/delete', :to => 'etds#destroy', :as => :destroy_etd
  get '/etds/:id/add_creator', :to => 'etds#add_creator', :as => :add_creator_to_etd
  get '/etds/:id/add_collaborator', :to => 'etds#add_collaborator', :as => :add_collaborator_to_etd
  post '/etds/:id/find', :to => 'etds#find_person', :as => :find_person_for_etd
  post '/etds/:id/find_person', :to => 'etds#save_person', :as => :save_person_to_etd
  get '/etds/:id/contents', :to => 'etds#contents', :as => :etd_contents
  get '/etds/:id/add_contents', :to => 'etds#add_contents', :as => :add_contents_to_etd
  put '/etds/:id/contents', :to => 'etds#save_contents', :as => :save_contents_to_etd
  get '/etds/:id/add_reason', :to => 'etds#pick_reason', :as => :pick_reason_for_etd
  post '/etds/:id/add_reason', :to => 'etds#add_reason', :as => :add_reason_to_etd
  get '/etds/:id/survey', :to => 'etds#survey', :as => :survey
  post '/etds/:id/submit', :to => 'etds#submit', :as => :submit_etd
  post '/etds/:id/vote', :to => 'etds#vote', :as => :vote_for_etd
  post '/etds/:id/unsubmit', :to => 'etds#unsubmit', :as => :unsubmit_etd
  get '/etds/:id/reviewboard', :to => 'etds#reviewboard', :as => :etd_reviewboard
  post '/etds/:id/approve', :to => 'etds#approve', :as => :approve_etd
  get '/etds/:id/delay_release', :to => 'etds#delay_release', :as => :delay_release
  post '/etds/:id/delay_release', :to => 'etds#process_delay_release', :as => :process_delay_release
  resources :etds, :except => :destroy

  get '/contents/:id/download', :to => 'contents#download', :as => :download_content
  post '/contents/:id/delete', :to => 'contents#destroy', :as => :destroy_content
  post '/contents/:id/update_availability', :to => 'contents#update_availability', :as => :update_content_availability
  resources :contents, :only => [:edit, :update, :show]

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
  post '/reasons/:id/delete', :to => 'reasons#destroy', :as => :destroy_reasons
  resources :reasons, :except => :destroy

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

  get '/conversations/:id/show', :to => 'conversations#show', :as => :conversation
  get '/conversations/:id/read', :to => 'conversations#read', :as => :read_conversation
  get '/conversations/:id/unread', :to => 'conversations#unread', :as => :unread_conversation
  get '/conversations/:id/archive', :to => 'conversations#archive', :as => :archive_conversation
  get '/conversations/:id/unarchive', :to => 'conversations#unarchive', :as => :unarchive_conversation
  match '/conversations/new', :to => 'conversations#new', :as => :new_conversation
  post '/conversations/confirm_new', :to => 'conversations#confirm_new', :as => :confirm_new_conversation
  post '/conversations', :to => 'conversations#create', :as => :create_conversation
  get '/conversations/:id/reply', :to => 'conversations#reply', :as => :reply_to_conversation
  post '/conversations/:id/reply', :to => 'conversations#send_reply', :as => :send_reply_to_conversation
  #get '/conversations/:id/reply_all', :to => 'conversations#reply_all', :as => :reply_all
  #post '/conversations/:id/reply_all', :to => 'conversations#send_reply_all', :as => :send_reply_all
  # This goes at the bottom so the above routes will resolve correctly.
  get '/conversations(/:box)', :to => 'conversations#mailbox', :as => :conversations

  # Resque's routes.
  mount Resque::Server.new, at: "/resque"

  # These could capture anything, but since they're at the bottom, they should only match the stuff that falls through.
  get '/:availability/:urn', :to => 'etds#old_show', :constraints => UrnConstraint.new()
  get '/:availability/:urn/:file_availability/:filename', :to => 'contents#old_show', :constraints => UrnConstraint.new()
end
