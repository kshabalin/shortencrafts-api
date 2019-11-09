class User < ApplicationRecord
  has_secure_password

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/i }
  validates :password, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  has_many :links
end
