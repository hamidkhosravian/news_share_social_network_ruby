class Comment < ApplicationRecord
  acts_as_votable
  
  belongs_to :post
  belongs_to :profile
  validates :content, presence: true, length: { maximum: 500 }
end
