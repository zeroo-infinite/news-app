namespace :article_summary do
  desc "日別、週間、月間のpv数とコメント数を記事毎で集計"
  task summary: :environment do
    daily_summary = ArticleSummaries::DailyArticleSummaryService.new
    daily_summary.execute
    weekly_summary = ArticleSummaries::WeeklyArticleSummaryService.new
    weekly_summary.execute
    monthly_summary = ArticleSummaries::MonthlyArticleSummaryService.new
    monthly_summary.execute
  end
end