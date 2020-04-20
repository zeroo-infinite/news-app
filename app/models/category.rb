class Category < ApplicationRecord
  has_many :articles, dependent: :nullify
  validates :name, uniqueness: true, presence: true, length: { maximum: 191 }
end
