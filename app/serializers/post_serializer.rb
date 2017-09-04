class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :address, :created_at, :attachment, :views_count, :liked, :like_size, :comments_count
  has_many :categories

  def profile
    ProfileSerializer.new(object.profile)
  end

  def attachment
    "#{ENV["BASE_URL"]}#{object.attachment.url}" if object.attachment.exists?
  end

  def views_count
    object.impressionist_count(filter: :user_id)
  end

  def liked
    current_user.liked? object
  end

  def like_size
    object.get_likes.size
  end

  def comments_count
    object.comments_count
  end
end
