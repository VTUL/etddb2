source 'http://rubygems.org'

gem 'rails', '~> 3.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~> 1.3.5', :require => 'sqlite3'
#gem 'net-ldap' , '0.1.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', " ~> 3.2.3"
  gem 'coffee-rails', " ~> 3.2.1"
  gem 'uglifier'
  #gem 'haml'
end

#For AJAX:
gem 'jquery-rails'

#JS requirements
gem 'execjs'
gem 'therubyracer'

gem 'ruby-ldap', '0.9.10'
#gem 'ruby-ldap', '0.9.11'
# For test,
group :development do
  #gem 'rspec-rails','2.5.0'
  gem "rails_code_qa", "~> 0.5.1"
  gem 'thin'
end
group :test do
  #gem 'rspec','2.5.0'
  gem 'webrat', '0.7.1'
  gem "rails_code_qa", "~> 0.5.1"
end

# For user authorization
gem 'cancan'

# For authentication
gem 'devise'

# For test,
#gem 'test_helper'

# For multiple file upload
gem 'paperclip'
#gem 'carrierwave'
gem 'nested_form', :git => "https://github.com/ryanb/nested_form.git"
gem 'mime-types'

# For pagination
gem 'will_paginate', '3.0.3'

# For messaging
gem 'mailboxer'

# For ip filtering
gem 'netaddr'

# For Full Text Search
gem 'sunspot_rails'
gem 'sunspot_solr'


# For Pure ruby ldap, one day test
#gem 'rubygem-net-ldap', '0.1.1'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
