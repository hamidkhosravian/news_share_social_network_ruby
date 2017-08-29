class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :name, :avatar

  def user_id
    object.user.id
  end

  def avatar
    "#{ENV["BASE_URL"]}#{object.avatar.url}" if object.avatar.exists?
  end
end
