class Click < ApplicationRecord
  belongs_to :link
  validates :link, presence: true
  validates :country_code, :country, presence: true

  scope :default, -> { where.not(country: nil) }
  scope :by_country, ->(country) { where('country ILIKE ?', country) }
end
