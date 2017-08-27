class Profile < ApplicationRecord
  has_attached_file :avatar, styles: { thumbnail: "100x100>", medium: "300x300>", large: "700x700>" }, url: "/:user_email/profile/:id-:name/avatar/:filename"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 10.megabytes

  belongs_to :user
  enum gender: [:male, :female, :other]

  Paperclip.interpolates :user_id do |file, style|
    "#{file.instance.user.id}"
  end

  Paperclip.interpolates :user_email do |file, style|
    "#{file.instance.user.email}"
  end
end
