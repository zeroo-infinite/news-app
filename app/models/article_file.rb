class ArticleFile < ApplicationRecord
  validates :name, null: false, length: { in: 1..100 }, presence: true
  validates :slug, null: false, length: { in: 1..100 }, uniqueness: true
  validates :file_url, null: false
  paginates_per 10
  mount_uploader :file_url, ArticleFileUploader
end
