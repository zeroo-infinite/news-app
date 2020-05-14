module UserSummaries
  class DailyUserSummaryService
    # コメントとpv数
    def execute
      date = Date.yesterday
      users = User.includes(:articles).where(role: "admin")
      users.each do |user|
        article_ids = user.articles.map { |article| article.id }
        summaries = DailyArticleSummary.where(date: date).where(article_id: article_ids)
        next if summaries.empty?
        pv_count = 0
        comment_count = 0
        summaries.each do |summary|
          pv_count += summary.pv_count
          comment_count += summary.comment_count
        end
        DailyUserSummary.create!(
          user_id: user.id,
          pv_count: pv_count,
          comment_count: comment_count,
          date: date
        )
      end
    end
  end
end