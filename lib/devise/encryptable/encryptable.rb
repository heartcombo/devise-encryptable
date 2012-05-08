require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require "devise"

module Devise
  # Declare encryptors length which are used in migrations.
  ENCRYPTORS_LENGTH = {
    :sha1   => 40,
    :sha512 => 128,
    :clearance_sha1 => 40,
    :restful_authentication_sha1 => 40,
    :authlogic_sha512 => 128
  }

  # Used to define the password encryption algorithm.
  mattr_accessor :encryptor
  @@encryptor = nil

  module Encryptable
    module Encryptors
      autoload :AuthlogicSha512, 'devise/encryptable/encryptors/authlogic_sha512'
      autoload :Base, 'devise/encryptable/encryptors/base'
      autoload :ClearanceSha1, 'devise/encryptable/encryptors/clearance_sha1'
      autoload :RestfulAuthenticationSha1, 'devise/encryptable/encryptors/restful_authentication_sha1'
      autoload :Sha1, 'devise/encryptable/encryptors/sha1'
      autoload :Sha512, 'devise/encryptable/encryptors/sha512'
    end

    extend ActiveSupport::Concern

    included do
      attr_reader :password, :current_password
      attr_accessor :password_confirmation
    end

    def self.required_fields(klass)
      [:password_salt]
    end

    # Generates password salt when setting the password.
    def password=(new_password)
      self.password_salt = self.class.password_salt if new_password.present?
      super
    end

    # Validates the password considering the salt.
    def valid_password?(password)
      puts "I'm here"
      return false if encrypted_password.blank?
      encryptor_class.compare(encrypted_password, password, self.class.stretches, authenticatable_salt, self.class.pepper)
    end

    # Overrides authenticatable salt to use the new password_salt
    # column. authenticatable_salt is used by `valid_password?`
    # and by other modules whenever there is a need for a random
    # token based on the user password.
    def authenticatable_salt
      self.password_salt
    end

    protected

    # Digests the password using the configured encryptor.
    def password_digest(password)
      if password_salt.present?
        encryptor_class.digest(password, self.class.stretches, authenticatable_salt, self.class.pepper)
      end
    end

    def encryptor_class
      self.class.encryptor_class
    end

    module ClassMethods
      Devise::Models.config(self, :encryptor)

      # Returns the class for the configured encryptor.
      def encryptor_class
        @encryptor_class ||= case encryptor
          when :bcrypt
            raise "In order to use bcrypt as encryptor, simply remove :encryptable from your devise model"
          when nil
            raise "You need to give an :encryptor as option in order to use :encryptable"
          else
            Devise::Encryptable::Encryptors.const_get(encryptor.to_s.classify)
        end
      end

      def password_salt
        self.encryptor_class.salt(self.stretches)
      end
    end
  end
end

Devise.add_module(:encryptable, :model => 'devise/encryptable/model')