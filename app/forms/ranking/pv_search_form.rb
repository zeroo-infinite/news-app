module Ranking
  class PvSearchForm
    include ActiveModel::Model
    attr_accessor :term

    def initialize(args = {})
      @term = args[:term]
    end

    def search
      date = Date.yesterday
      case @term
      when "daily"
        summaries = DailyPvSummary.includes(article: :category).where(date: date).order(pv_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      when "weekly"
        summaries = WeeklyPvSummary.includes(article: :category).where(end_date: date).order(pv_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      when "monthly"
        summaries = MonthlyPvSummary.includes(article: :category).where(end_date: date).order(pv_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      else
        summaries = DailyPvSummary.includes(article: :category).where(date: date).order(pv_count: :desc).limit(10)
        summaries.map { |summary| summary.article }
      end
    end
  end
end