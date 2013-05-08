class User < ActiveRecord::Base
  devise :database_authenticatable, :encryptable
end
