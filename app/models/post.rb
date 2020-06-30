class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories, dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }
  validates :categories, presence: true

  before_validation :generate_slug

  private

  def generate_slug
    return if title.blank?

    self.slug = title.parameterize if slug.blank?
  end
end
