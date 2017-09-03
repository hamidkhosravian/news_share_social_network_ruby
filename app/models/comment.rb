class Comment < ApplicationRecord
  belongs_to :post, presence: true
  belongs_to :profile, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
