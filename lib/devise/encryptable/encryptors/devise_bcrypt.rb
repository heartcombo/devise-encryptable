require 'bcrypt'

begin
  module Devise
    module Encryptable
      module Encryptors
        # Adapted from
        # https://github.com/heartcombo/devise/blob/8593801130f2df94a50863b5db535c272b00efe1/lib/devise/encryptor.rb
        class DeviseBcrypt < Base
          def self.compare(hashed_password, password, stretches, _salt, pepper)
            return false if hashed_password.blank?
            bcrypt = ::BCrypt::Password.new(hashed_password)
            if pepper.present?
              password = "#{password}#{pepper}"
            end
            password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)
            Devise.secure_compare(password, hashed_password)
          rescue BCrypt::Errors::InvalidHash
            # this probably means the password has already been migrated
            false
          end

          def self.digest(password, stretches, _salt, pepper)
            if pepper.present?
              password = "#{password}#{pepper}"
            end
            ::BCrypt::Password.create(password, cost: stretches).to_s
          end
        end
      end
    end
  end
end
