class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :category

  validates :tag_id, uniqueness: { scope: :post_id }
end
