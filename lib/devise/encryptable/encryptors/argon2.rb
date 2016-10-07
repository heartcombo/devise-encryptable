begin
  require 'argon2'
rescue NoMethodError
  module Argon2
    class Password
      def initialize(*args)
        raise NotImplementedError, "argon2 gem required for Devise::Encryptable configuration"
      end
    end
  end
end

module Devise
  module Encryptable
    module Encryptors
      class Argon2 < Base
        def self.digest(password, stretches, salt, pepper)
          argon2_args = { m_cost: stretches, t_cost: 2 }
          if pepper
            argon2_args[:secret] = pepper
          end
          password ||= ''
          argon2 = ::Argon2::Password.new(argon2_args)
          argon2.create(password + salt)
        end
      end
    end
  end
end
