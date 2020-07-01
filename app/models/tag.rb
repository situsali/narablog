class Tag < ApplicationRecord
  has_many :post_tags
  has_many :post, through: :post_tags

  validates :name, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }

  before_validation :generate_slug

  private

  def generate_slug
    return if name.blank?

    self.slug = name.parameterize if slug.blank?
  end
end
