class Profile < ApplicationRecord
  has_attached_file :avatar, styles: { thumbnail: "100x100>", medium: "400x400>", large: "700x700>" }, url: "/Users/:user_id-:user_email/Profile/:id-:name/Avatar/:filename"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  enum gender: [:male, :female, :other]

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  belongs_to :user

   # Follows a user.
   def follow(id)
     active_relationships.create(followed_id: id)
   end
   # Unfollows a user.
   def unfollow(id)
     active_relationships.find_by(followed_id: id).destroy
   end
   # Returns true if the current user is following the other user.
   def following?(profile)
     following.include?(profile)
   end

  private
    Paperclip.interpolates :name do |file, style|
      "#{file.instance.name}"
    end

    Paperclip.interpolates :user_id do |file, style|
      "#{file.instance.user.id}"
    end

    Paperclip.interpolates :user_email do |file, style|
      "#{file.instance.user.email}"
    end
end
