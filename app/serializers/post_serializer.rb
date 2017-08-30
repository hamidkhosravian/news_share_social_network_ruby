class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :address, :created_at, :attachment

  def profile
    ProfileSerializer.new(object.profile)
  end

  def attachment
    "#{ENV["BASE_URL"]}#{object.attachment.url}" if object.attachment.exists?
  end
end
