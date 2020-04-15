module Admin
  module Articles
    class SearchForm
      include ActiveModel::Model
      attr_accessor :title, :status, :category_id
      extend Enumerize
      enumerize :status, in: { draft: 0, release: 1 }, predicates: true

      def initialize(args = {})
        @title = args[:title]
        @status = args[:status]
        @category_id = args[:category_id]
      end

      def search(articles, page)
        articles = articles.where(category_id: category_id) if category_id.present?
        articles = articles.where('title LIKE ?', "%#{title}%") if title.present?
        articles = articles.where(status: status) if status.present?
        articles = articles.order(created_at: :desc).page(page)
      end
    end
  end
end