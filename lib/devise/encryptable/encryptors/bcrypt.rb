require 'bcrypt'

module Devise
  module Encryptable
    module Encryptors
      class Bcrypt  < Base
        def self.digest(password, stretches, salt, pepper)
          # If not comparing bcrypt creates the salt for you.
          salt = ::BCrypt::Engine.generate_salt(stretches) if salt.blank?

          # Ignoring stretches since this is autodetected from the salt.
          ::BCrypt::Engine.hash_secret("#{password}#{pepper}", salt).to_s
        end

        def self.compare(encrypted_password, password, stretches, salt, pepper)
          # Ignore the salt and use the salt of the encrypted password.
          bcrypt = ::BCrypt::Password.new(encrypted_password)
          Devise.secure_compare(encrypted_password, digest(password, stretches, bcrypt.salt, pepper))
        end
      end
    end
  end
end