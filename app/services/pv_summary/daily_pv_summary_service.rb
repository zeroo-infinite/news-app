module PvSummary
  class DailyPvSummaryService
    # 記事毎のpv数を日別で集計する
    def total_pv
      articles = Article.where(status: "release").where('released_at <= ?', Time.current)
      articles.each do |article|
        ActiveRecord::Base.transaction do
          summary = article.daily_pv_summaries.build
          summary.pv_count = article.pv_count
          summary.date = Date.yesterday
          summary.save!
          article.update!(pv_count: 0)
        end
      end
    end
  end
end