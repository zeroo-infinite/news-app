module ArticleSummaries
  class WeeklyArticleSummaryService
    # 記事毎のpv数とコメント数を週間で集計する
    def summary
      date = Date.today
      article_ids = DailyPvSummary.where(date: date.ago(7.days)..date.yesterday).select(:article_id).distinct
      article_ids.each do |article_id|
        summaries = DailyPvSummary.where(date: date.ago(7.days)..date.yesterday).where(article_id: article_id.article_id)
        pv_count = 0
        comment_count = 0
        summaries.each do |summary|
          pv_count += summary.pv_count
          comment_count += summary.comment_count
        end
        WeeklyPvSummary.create!(
          article_id: article_id.article_id,
          pv_count: pv_count,
          comment_count: comment_count,
          start_date: date.ago(7.days),
          end_date: date.yesterday
        )
      end
    end
  end
end