require "digest/sha1"

module Devise
  module Encryptable
    module Encryptors
      # = Sha1
      # Uses the Sha1 hash algorithm to encrypt passwords.
      class LdapSsha < Base
        # Generates a default password digest based on salt and the incoming password.
        def self.digest(password, stretches, salt, pepper)
          self.secure_digest(password, salt)
        end

        def self.salt(stretches)
          Devise.friendly_token[0,4]
        end

        private

        # Generate a SHA1 digest with salt
        def self.secure_digest(password, salt)
          raise "Invalid salt: #{salt}" if salt.size != 4
          "{SSHA}" + Base64.encode64(Digest::SHA1.digest("#{password}#{salt}") + salt).strip
        end
      end
    end
  end
end
