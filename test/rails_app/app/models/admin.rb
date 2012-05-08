class Admin < ActiveRecord::Base
  devise :database_authenticatable, :encryptable

  attr_accessible :email, :password, :password_confirmation
end