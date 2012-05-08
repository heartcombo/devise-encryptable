require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require "minitest/autorun"
require "minitest/unit"

require "rails_app/config/environment"
require "devise/encryptable/encryptable"

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::Migrator.migrate(File.expand_path("test/rails_app/db/migrate"))