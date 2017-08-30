class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :address, :created_at, :attachment, :views_count

  def profile
    ProfileSerializer.new(object.profile)
  end

  def attachment
    "#{ENV["BASE_URL"]}#{object.attachment.url}" if object.attachment.exists?
  end

  def views_count
    object.impressionist_count(filter: :user_id)
  end
end
