class Page < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }

  before_validation :generate_slug

  private

  def generate_slug
    return if title.blank?

    self.slug = title.parameterize if slug.blank?
  end
end
