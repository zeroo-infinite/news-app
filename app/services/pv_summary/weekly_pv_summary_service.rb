module PvSummary
  class WeeklyPvSummaryService
    # 記事毎のpv数を週間で集計する
    def total_pv
      date = Date.today
      article_ids = DailyPvSummary.where(date: date.ago(7.days)..date.yesterday).select(:article_id).distinct
      article_ids.each do |article_id|
        summaries = DailyPvSummary.where(date: date.ago(7.days)..date.yesterday).where(article_id: article_id.article_id)
        pv = 0
        summaries.each { |summary| pv += summary.pv_count }
        WeeklyPvSummary.create!(
          article_id: article_id.article_id,
          pv_count: pv,
          start_date: date.ago(7.days),
          end_date: date.yesterday
        )
      end
    end
  end
end