require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require "minitest/autorun"
require "minitest/unit"

require "mocha"

require "rails_app/config/environment"
require "devise/encryptable/encryptable"

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)

ActiveRecord::Migrator.migrate(File.expand_path("test/rails_app/db/migrate"))

def swap(object, new_values)
  old_values = {}
  new_values.each do |key, value|
    old_values[key] = object.send key
    object.send :"#{key}=", value
  end
  yield
ensure
  old_values.each do |key, value|
    object.send :"#{key}=", value
  end
end