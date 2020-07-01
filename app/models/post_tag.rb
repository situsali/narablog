class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tags

  validates :tag_id, uniqueness: { scope: :post_id }
end
