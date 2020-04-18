class Article < ApplicationRecord
  extend Enumerize
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  has_many :article_histories
  belongs_to :category, optional: true
  belongs_to :user
  paginates_per 10
  enumerize :status, in: { draft: 0, release: 1 }, default: :draft, predicates: true, scope: true

  scope :order_created_at_desc, -> { order(created_at: :desc) }
  scope :released_articles, -> { with_status(:release).where("released_at <= ?", Time.zone.now) }

  def update_with_history!(current_user)
    ActiveRecord::Base.transaction do
      save!
      ArticleHistory.create_article_history!(saved_changes, self, current_user)
    end
  end
end
