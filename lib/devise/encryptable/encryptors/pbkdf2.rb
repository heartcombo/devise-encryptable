begin
  require "pbkdf2"

  module Devise
    module Encryptable
      module Encryptors
        # = PBKDF2
        # Uses the PBKDF2 algorithm to encrypt passwords.
        class Pbkdf2 < Base
          def self.digest(password, stretches, salt, pepper)
            ::PBKDF2.new(password: password, salt: "#{[salt].pack('H*')}#{pepper}", iterations: stretches, hash_function: 'sha1', key_length: 64).hex_string
          end
        end
      end
    end
  end
rescue LoadError
  # Need pbkdf2 library installed to use this encryptor
end
