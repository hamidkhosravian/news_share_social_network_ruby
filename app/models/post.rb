class Post < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude   # can also be an IP address
	after_validation :geocode
  validates :content, presence: true, length: { maximum: 500 }

  belongs_to :profile
end
