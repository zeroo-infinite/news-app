class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  belongs_to :category, optional: true
  belongs_to :user
  paginates_per 10
  mount_uploader :image_url, ImageUploader

  scope :order_created_at_desc, -> { order(created_at: :desc) }
end
