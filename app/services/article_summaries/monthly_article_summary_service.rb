module ArticleSummaries
  class MonthlyArticleSummaryService
    # 記事毎のpv数とコメント数を月間で集計する
    def execute
      date = Date.today
      article_ids = DailyArticleSummary.where(date: date.ago(1.month)..date.yesterday).select(:article_id).distinct
      article_ids.each do |article_id|
        summaries = DailyArticleSummary.where(date: date.ago(1.month)..date.yesterday).where(article_id: article_id.article_id)
        pv_count = 0
        comment_count = 0
        summaries.each do |summary|
          pv_count += summary.pv_count
          comment_count += summary.comment_count
        end
        MonthlyArticleSummary.create!(
          article_id: article_id.article_id,
          pv_count: pv_count,
          comment_count: comment_count,
          start_date: date.ago(1.month),
          end_date: date.yesterday
        )
      end
    end
  end
end