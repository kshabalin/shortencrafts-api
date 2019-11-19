class Click < ApplicationRecord
  belongs_to :link
  validates :link, presence: true
  validates :country_code, :country, presence: true

  scope :default, -> { where.not(country: nil) }
  scope :by_country, ->(country) { where('country ILIKE ?', country) }
  scope :from_occurred_at, ->(date) { where('clicks.occurred_at >= ?', date) }
  scope :to_occurred_at, ->(date) { where('clicks.occurred_at <= ?', date) }
end
