class RestrictedWhitelist
  def initialize
    @ipv4 = [NetAddr::CIDR.create('128.173.0.0/16')]    # Blacksburg
    @ipv4 << NetAddr::CIDR.create('198.82.0.0/16')      # Blacksburg
    @ipv4 << NetAddr::CIDR.create('208.22.18.0/24')     # NOVA
    @ipv4 << NetAddr::CIDR.create('208.29.54.0/24')     # NOVA

    @ipv6 = [NetAddr::CIDR.create('2001:468:c80::/48')] # Blacksburg
    @ipv6 << NetAddr::CIDR.create('2002:80ad::/32')     # Blacksburg, 6in4 from 128.173.0.0::/16
    @ipv6 << NetAddr::CIDR.create('2002:2652::/32')     # Blacksburg, 6in4 from 198.82.0.0::/16

    @metaarchive = []
    File.open("#{Rails.root}/lib/MetaArchive.ips") do |f|
      @metaarchive = f.lines.to_a.map { |l| l.strip }
    end
  end

  def matches?(request)
    valid = []
    # Allow on-campus access
    # I'd rather this be an if, and sort the ip addresses, but I'm loathe to add another gem (and this works).
    begin
      valid = @ipv4.select {|subnet| subnet.contains?(request.remote_ip) }
    rescue NetAddr::VersionError => e
      valid = @ipv6.select {|subnet| subnet.contains?(request.remote_ip) }
    end

    # Allow MetaArchive access
    if Rails.env == "production" and @metaarchive.include?(request.remote_ip)
      valid << true
    end

    # Allow local dev work.
    if Rails.env == "development" and ['127.0.0.1', '::1'].include?(request.remote_ip)
      valid << true
    end

    !valid.empty?
  end
end

class EtdConstraint
  def initialize
    @avails = Availability.pluck(:name)
    @urn = /etd-\d+(-\d+)?/
  end

  def matches?(request)
    @avails.include?(params[:availability]) && @urn.match(params[:etd_urn])
  end
end

NewVtEtdUpgrd::Application.routes.draw do

  # These are boring static pages.
  root :to => 'pages#home'
  get '/about', :to => 'pages#about', :constraints => RestrictedWhitelist.new
  get '/contact', :to => 'pages#contact'
  get '/authorhelp', :to => 'pages#authorhelp'
  get '/staffhelp', :to => 'pages#staffhelp'
  get '/dev', :to => 'pages#dev'

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
  # This allows us to link to a attached model, and not get errors with LegacyPeople.
  # However, this route never needs to resolve, it is absorbed by the resources route above it. It just needs to be named.
  get '/people/:id', :to => 'people#show', :as => :legacy_person

  post '/etds/:id/delete', :to => 'etds#destroy', :as => :destroy_etd
  get '/etds/add_author/:id', :to => 'etds#add_author', :as => :add_author_to_etd
  post '/etds/add_author/:id', :to => 'etds#save_author', :as => :save_author_to_etd
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

  get '/conversations/show/:id', :to => 'conversations#show', :as => :conversation
  get '/conversations/read/:id', :to => 'conversations#read', :as => :read_conversation
  get '/conversations/unread/:id', :to => 'conversations#unread', :as => :unread_conversation
  get '/conversations/archive/:id', :to => 'conversations#archive', :as => :archive_conversation
  get '/conversations/unarchive/:id', :to => 'conversations#unarchive', :as => :unarchive_conversation
  match '/conversations/new', :to => 'conversations#new', :as => :new_conversation
  post '/conversations/confirm_new', :to => 'conversations#confirm_new', :as => :confirm_new_conversation
  post '/conversations', :to => 'conversations#create', :as => :create_conversation
  get '/conversations/reply/:id', :to => 'conversations#reply', :as => :reply_to_conversation
  post '/conversations/reply/:id', :to => 'conversations#send_reply', :as => :send_reply_to_conversation
  #get '/conversations/reply_all/:id', :to => 'conversations#reply_all', :as => :reply_all
  #post '/conversations/reply_all/:id', :to => 'conversations#send_reply_all', :as => :send_reply_all
  # This goes here so the above routes will resolve correctly.
  get '/conversations(/:box)', :to => 'conversations#mailbox', :as => :conversations

  # These could capture anything, but since they're at the bottom, they should only match the stuff that falls through.
  get '/:availability/:urn', :to => 'etds#show', :as => :etd_path, :constraints => EtdConstraint.new
  get '/:availability/:urn/:file_availability/:filename', :to => 'contents#get_file', :constraints => EtdConstraint.new

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end
