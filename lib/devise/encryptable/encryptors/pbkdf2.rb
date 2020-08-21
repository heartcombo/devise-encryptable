begin
  module Devise
    module Encryptable
      module Encryptors
        class Pbkdf2 < Base
          def self.compare(encrypted_password, password, stretches, salt, pepper)
            value_to_test = self.digest(password, stretches, salt, pepper)
            ActiveSupport::SecurityUtils.fixed_length_secure_compare(encrypted_password, value_to_test)
          end

          def self.digest(password, stretches, salt, pepper)
            hash = OpenSSL::Digest::SHA512.new
            OpenSSL::KDF.pbkdf2_hmac(
              password,
              salt: "#{[salt].pack('H*')}#{pepper}",
              iterations: stretches,
              hash: hash,
              length: hash.digest_length,
            ).unpack('H*')[0]
          end
        end
      end
    end
  end
end
