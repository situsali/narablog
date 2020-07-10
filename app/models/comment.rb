class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  scope :in_post, lambda { |post_id|
    where(commentable_id: post_id).order('created_at DESC').limit(10)
  }
end
