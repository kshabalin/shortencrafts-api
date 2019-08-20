class Click < ApplicationRecord
  belongs_to :link
  validates :country_code, :country, presence: true
end
