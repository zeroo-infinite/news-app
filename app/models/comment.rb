class Comment < ApplicationRecord
  belongs_to :article
  validates :comment, presence: true, length: { maximum: 500 }
end
