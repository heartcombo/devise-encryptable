class User < ActiveRecord::Base
  devise :encryptable, :database_authenticatable

  attr_accessible :email, :password, :password_confirmation
end