module ArticleSummaries
  class DailyArticleSummaryService
    # 記事毎のpv数とコメント数を日別で集計する
    def execute
      date = Date.yesterday
      from = date.beginning_of_day
      to = date.end_of_day
      articles = Article.where(status: "release").where('released_at <= ?', to)
      articles.each do |article|
        ActiveRecord::Base.transaction do
          summary = article.daily_article_summaries.build
          comment = article.comments.where(created_at: from..to)
          summary.pv_count = article.pv_count
          summary.comment_count = comment.size
          summary.date = date
          summary.save!
          article.update!(pv_count: 0)
        end
      end
    end
  end
end