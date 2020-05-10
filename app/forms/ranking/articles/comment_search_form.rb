module Ranking
  module Articles
    class CommentSearchForm
      include ActiveModel::Model
      attr_accessor :term
      attr_accessor :category_name

      def initialize(args = {})
        @term = args[:term]
        @category = args[:category_name]
      end

      def search
        date = Date.yesterday
        model = find_term_model
        category = Category.find_by(name: @category)
        if @category.present?
          summaries = model.top_comment_summaries(date)
          articles = []
          summaries.each { |summary| articles.push(summary.article) if summary.article.category_id == category.id }
          articles.take(10)
        else
          summaries = model.top_comment_summaries(date).limit(10)
          summaries.map { |summary| summary.article }
        end
      end

      private

      def find_term_model
        case @term
        when "daily"
          DailyArticleSummary
        when "weekly"
          WeeklyArticleSummary
        when "monthly"
          MonthlyArticleSummary
        else
          DailyArticleSummary
        end
      end
    end
  end
end