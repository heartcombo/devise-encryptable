source 'https://rubygems.org'

gem "devise-encryptable", :path => ".."

gem 'devise', :git => "git@github.com:plataformatec/devise.git", :branch => "removing_encryptable"
gem 'minitest'
gem 'rails', "3.1.4"
gem 'sqlite3'

gem 'mocha', :require => false

gem 'pry'
gem 'pry-doc'
gem 'pry-nav'
gem 'awesome_print'