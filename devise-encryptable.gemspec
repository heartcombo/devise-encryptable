# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise/encryptable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Carlos Antonio da Silva', 'José Valim', 'Rodrigo Flores']
  gem.email         = 'opensource@plataformatec.com.br'
  gem.description   = 'Encryption solution for salted-encryptors on Devise'
  gem.summary       = 'Encryption solution for salted-encryptors on Devise'
  gem.homepage      = 'http://github.com/plataformatec/devise-encryptable'
  gem.license       = 'Apache 2.0'

  gem.files         = Dir['Changelog.md', 'LICENSE', 'README.md', 'lib/**/*']
  gem.test_files    = Dir['test/**/*.rb']
  gem.name          = 'devise-encryptable'
  gem.require_paths = ['lib']
  gem.version       = Devise::Encryptable::VERSION

  gem.add_dependency 'devise', '>= 2.1.0'
end
