ENV["RAILS_ENV"] = "test"
require "devise"
require "devise/version"
require "active_support/core_ext/module/attribute_accessors"

require "devise/encryptable/encryptable"

require "rails_app/config/environment"
require "rails/test_help"
require "mocha/setup"

require 'support/assertions'
require 'support/factories'
require 'support/swappers'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::Migrator.migrate(File.expand_path("test/rails_app/db/migrate"))
