class CommentSerializer < ActiveModel::Serializer
  attributes :post_id, :content
  has_one :profile
end
