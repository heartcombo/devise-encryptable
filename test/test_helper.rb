ENV["RAILS_ENV"] = "test"
require "devise"
require "devise/version"
require "active_support/core_ext/module/attribute_accessors"

require "devise/encryptable/encryptable"

require "rails_app/config/environment"
require "rails/test_help"
require "mocha/minitest"

require 'support/assertions'
require 'support/factories'
require 'support/swappers'

if ActiveSupport.respond_to?(:test_order)
  ActiveSupport.test_order = :random
end

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

migrate_path = File.expand_path("rails_app/db/migrate/", __dir__)
if Rails.version.start_with? '7.0'
  ActiveRecord::MigrationContext.new(migrate_path, ActiveRecord::SchemaMigration).migrate
else
  ActiveRecord::MigrationContext.new(migrate_path).migrate
end
