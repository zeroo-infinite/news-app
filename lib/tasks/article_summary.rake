namespace :article_summary do
  desc "日別、週間、月間のpv数とコメント数を記事毎で集計"
  task summary: :environment do
    daily_summary = ArticleSummaries::DailyArticleSummaryService.new
    daily_summary.summary
    weekly_summary = ArticleSummaries::WeeklyArticleSummaryService.new
    weekly_summary.summary
    monthly_summary = ArticleSummaries::MonthlyArticleSummaryService.new
    monthly_summary.summary
  end
end