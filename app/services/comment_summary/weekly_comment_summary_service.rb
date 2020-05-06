module CommentSummary
  class WeeklyCommentSummaryService
    def total_comment
      date = Date.today
      article_ids = DailyCommentSummary.where(date: date.ago(7.days)..date.yesterday).select(:article_id).distinct
      article_ids.each do |article_id|
        summaries = DailyCommentSummary.where(date: date.ago(7.days)..date.yesterday).where(article_id: article_id.article_id)
        comment_count = 0
        summaries.each { |summary| comment_count += summary.comment_count }
        WeeklyCommentSummary.create(
          article_id: article_id.article_id,
          comment_count: comment_count,
          start_date: date.ago(7.days),
          end_date: date.yesterday,
        )
      end
    end
  end
end