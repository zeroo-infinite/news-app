class Category < ApplicationRecord
  has_many :article_categorizations, dependent: :destroy
  has_many :articles, through: :article_categorizations
  validates :name, uniqueness: true, presence: true, length: { maximum: 191 }
end
