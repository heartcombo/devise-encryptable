# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise_encryptable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Carlos Antonio da Silva", "José Valim", "Rodrigo Flores"]
  gem.email         = "contact@plataformatec.com.br"
  gem.description   = %q{Encryption solution for salted-encryptors on Devise}
  gem.summary       = %q{Encryption solution for salted-encryptors on Devise}
  gem.homepage      = "http://github.com/plataformatec/classical_encryptors"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "devise_encryptable"
  gem.require_paths = ["lib"]
  gem.version       = DeviseEncryptable::VERSION
end
