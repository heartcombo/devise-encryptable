ENV["RAILS_ENV"] = "test"
require "devise"
require "active_support/core_ext/module/attribute_accessors"

require "devise/encryptable/encryptable"

require "minitest/autorun"
require "minitest/unit"

require "mocha/setup"

require "rails_app/config/environment"

require 'support/assertions'
require 'support/factories'
require 'support/swappers'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::Migrator.migrate(File.expand_path("test/rails_app/db/migrate"))
