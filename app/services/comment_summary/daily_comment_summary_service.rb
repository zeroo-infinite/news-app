module CommentSummary
  class DailyCommentSummaryService
    def total_comment
      date = Date.yesterday
      from = date.beginning_of_day
      to = date.end_of_day
      article_ids = Comment.where(created_at: from..to).select(:article_id).distinct
      article_ids.each do |article_id|
        comment = Comment.where(created_at: from..to).where(article_id: article_id.article_id)
        DailyCommentSummary.create(
          article_id: article_id.article_id,
          comment_count: comment.size,
          date: date
        )
      end
    end
  end
end