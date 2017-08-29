class Post < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude   # can also be an IP address
	after_validation :geocode
  validates :content, presence: true, length: { maximum: 500 }

  belongs_to :profile

  before_create :set_address

  private
    def set_address
      address = Geocoder.search("#{self.latitude},#{self.longitude}")[0]
      if address
        self.address = address.address
      else
        raise BadRequestError, "your coordinate is not valid!"
      end
    end
end
