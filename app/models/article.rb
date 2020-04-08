class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  belongs_to :user
end
