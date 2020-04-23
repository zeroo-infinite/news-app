class Article < ApplicationRecord
  extend Enumerize
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  has_many :article_histories
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :user
  attr_accessor :change_type
  paginates_per 10
  enumerize :status, in: { draft: 0, release: 1 }, default: :draft, predicates: true, scope: true

  scope :order_created_at_desc, -> { order(created_at: :desc) }
  scope :released_articles, -> { with_status(:release).where("released_at <= ?", Time.zone.now) }

  def update_with_history!(current_user)
    ActiveRecord::Base.transaction do
      save!
      self.change_type = "update"
      ArticleHistory.create_article_history!(saved_changes, self, current_user)
    end
  end

  def delete_with_history!(current_user)
    ActiveRecord::Base.transaction do
      self.change_type = "delete"
      ArticleHistory.create_article_history!(saved_changes, self, current_user)
      destroy!
    end
  end
end
