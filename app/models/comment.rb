class Comment < ApplicationRecord
  acts_as_votable

  belongs_to :post, counter_cache: :comments_count
  belongs_to :profile
  validates :content, presence: true, length: { maximum: 500 }
end
