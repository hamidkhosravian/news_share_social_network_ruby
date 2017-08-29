class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :address, :created_at

  def profile
    ProfileSerializer.new(object.profile)
  end
end
