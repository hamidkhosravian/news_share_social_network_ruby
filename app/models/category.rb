class Category < ApplicationRecord
  has_attached_file :icon, styles: { thumbnail: "50x50>", medium: "80x80>", large: "120x120>" }, url: "/Posts/:profile_id-:email/:id/:filename"
  validates_attachment_content_type :icon, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :icon, less_than: 1.megabytes

  validates :name, presence: true
  has_and_belongs_to_many :posts, -> { distinct }
end
