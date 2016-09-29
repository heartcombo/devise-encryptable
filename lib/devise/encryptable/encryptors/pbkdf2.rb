module Devise
  module Encryptable
    module Encryptors
      class Pbkdf2 < Base
        def self.digest(password, stretches, salt, pepper)
          pepper ||= ''
          password ||= ''
          digest = OpenSSL::Digest::SHA512.new
          len = digest.digest_length
          iterations = stretches > 1000 ? stretches : 100_000
          ::Digest::SHA512.hexdigest(OpenSSL::PKCS5.pbkdf2_hmac(pepper+password, salt, iterations, len, digest))
        end
      end
    end
  end
end
