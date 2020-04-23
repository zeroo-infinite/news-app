class ArticleHistory < ApplicationRecord
  extend Enumerize
  belongs_to :article
  validates :user_id, presence: true
  validates :article_id, presence: true
  enumerize :status, in: { draft: 0, release: 1 }, predicates: true, scope: true
  enumerize :change_type, in: { update: 0, delete: 1 }, predicates: true, scope: true

  def self.create_article_history!(changed_attributes, article)
    create!(
      article_id: article.id,
      category_id: changed_attributes["category_id"] ? changed_attributes["category_id"][0] : nil,
      title: changed_attributes["title"] ? changed_attributes["title"][0] : nil,
      slug: changed_attributes["slug"] ? changed_attributes["slug"][0] : nil,
      image_url: changed_attributes["image_url"] ? changed_attributes["image_url"][0] : nil,
      status: changed_attributes["status"] ? changed_attributes["status"][0] : nil,
      released_at: changed_attributes["released_at"] ? changed_attributes["released_at"][0] : nil
    )
  end
end
