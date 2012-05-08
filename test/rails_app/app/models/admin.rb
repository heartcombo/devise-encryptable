class Admin < ActiveRecord::Base
  devise :database_authenticatable, :encryptable

  @encryptor = :sha512

  attr_accessible :email, :password, :password_confirmation
end