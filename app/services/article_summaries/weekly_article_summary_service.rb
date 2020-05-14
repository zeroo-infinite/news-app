module ArticleSummaries
  class WeeklyArticleSummaryService
    # 記事毎のpv数とコメント数を週間で集計する
    def execute
      date = Date.today
      article_ids = DailyArticleSummary.where(date: date.ago(7.days)..date.yesterday).pluck(:article_id).uniq
      weekly_article_summaries = []
      article_ids.each do |article_id|
        daily_article_summaries = DailyArticleSummary.where(date: date.ago(7.days)..date.yesterday).where(article_id: article_id)
        pv_count = 0
        comment_count = 0
        daily_article_summaries.each do |daily_article_summary|
          pv_count += daily_article_summary.pv_count
          comment_count += daily_article_summary.comment_count
        end
        weekly_article_summaries << WeeklyArticleSummary.new(
          article_id: article_id,
          pv_count: pv_count,
          comment_count: comment_count,
          start_date: date.ago(7.days),
          end_date: date.yesterday
        )
      end
      WeeklyArticleSummary.import weekly_article_summaries
    end
  end
end