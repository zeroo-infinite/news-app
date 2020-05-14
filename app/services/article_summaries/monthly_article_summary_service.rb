module ArticleSummaries
  class MonthlyArticleSummaryService
    # 記事毎のpv数とコメント数を月間で集計する
    def execute
      date = Date.today
      article_ids = DailyArticleSummary.where(date: date.ago(1.month)..date.yesterday).pluck(:article_id).uniq
      monthly_article_summaries = []
      article_ids.each do |article_id|
        daily_article_summaries = DailyArticleSummary.where(date: date.ago(1.month)..date.yesterday).where(article_id: article_id)
        pv_count = 0
        comment_count = 0
        daily_article_summaries.each do |daily_article_summary|
          pv_count += daily_article_summary.pv_count
          comment_count += daily_article_summary.comment_count
        end
        monthly_article_summaries << MonthlyArticleSummary.new(
          article_id: article_id,
          pv_count: pv_count,
          comment_count: comment_count,
          start_date: date.ago(1.month),
          end_date: date.yesterday
        )
      end
      MonthlyArticleSummary.import monthly_article_summaries
    end
  end
end