class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :icon

  def icon
    "#{ENV["BASE_URL"]}#{object.icon.url}" if object.icon.exists?
  end
end
