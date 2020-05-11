class CreateArticleSummaryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "create_article_summary", retry: false

  def perform
    daily_summary = ArticleSummaries::DailyArticleSummaryService.new
    daily_summary.summary
    weekly_summary = ArticleSummaries::WeeklyArticleSummaryService.new
    weekly_summary.summary
    monthly_summary = ArticleSummaries::MonthlyArticleSummaryService.new
    monthly_summary.summary
  end
end