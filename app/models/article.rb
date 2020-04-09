class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  has_one :article_categorization, dependent: :destroy
  has_one :category, through: :article_categorization
  belongs_to :user
  paginates_per 10

  scope :order_created_at_desc, -> { order(created_at: :desc) }
end
