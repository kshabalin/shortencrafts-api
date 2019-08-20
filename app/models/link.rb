class Link < ApplicationRecord
  has_many :clicks, dependent: :destroy
  validates :url_hash, presence: true, length: { is: 6 }, uniqueness: true
  validates :url, presence: true
end
