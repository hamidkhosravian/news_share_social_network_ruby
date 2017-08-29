class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :profile, :address, :created_at

  def profile
    ProfileSerializer.new(object.object.profile)
  end
end
