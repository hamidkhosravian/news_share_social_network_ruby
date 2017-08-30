class Post < ApplicationRecord
  has_attached_file :attachment, styles: { thumbnail: "500x500>", medium: "800x800>", large: "1200x1200>" }, url: "/Posts/:profile_id-:email/:id/:filename"
  validates_attachment_content_type :attachment, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :attachment, less_than: 5.megabytes

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

   Paperclip.interpolates :email do |file, style|
     "#{file.instance.profile.user.email}"
   end

  Paperclip.interpolates :profile_id do |file, style|
    "#{file.instance.profile_id}"
  end
end