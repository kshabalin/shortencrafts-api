class User < ApplicationRecord
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :password, length: { minimum: 8 }
  validates :password, confirmation: { case_sensitive: true }

  has_many :links
end
