class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  belongs_to :category, optional: true
  belongs_to :user
  paginates_per 10
  extend Enumerize
  enumerize :status, in: { draft: 0, release: 1 }, default: :draft, predicates: true, scope: true

  scope :order_created_at_desc, -> { order(created_at: :desc) }
end
