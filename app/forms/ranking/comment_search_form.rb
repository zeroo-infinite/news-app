module Ranking
  class CommentSearchForm
    include ActiveModel::Model
    attr_accessor :term

    def initialize(args = {})
      @term = args[:term]
    end

    def search
      date = Date.yesterday
      case @term
      when "daily"
        summaries = DailyArticleSummary.includes(article: :category).where(date: date).order(comment_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      when "weekly"
        summaries = WeeklyArticleSummary.includes(article: :category).where(end_date: date).order(comment_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      when "monthly"
        summaries = MonthlyArticleSummary.includes(article: :category).where(end_date: date).order(comment_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      else
        summaries = DailyArticleSummary.includes(article: :category).where(date: date).order(comment_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      end
    end
  end
end