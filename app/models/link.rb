class Link < ApplicationRecord
  has_many :clicks, dependent: :destroy
  validates :url_hash, presence: true, length: { is: 6 }, uniqueness: true
  validates :url, presence: true
  validates :url, format: { with: %r(\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z) }
end
