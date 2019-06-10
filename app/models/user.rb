class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest, :password_confirmation
  validates :email, uniqueness: true

  #encrypt password
  has_secure_password
end
