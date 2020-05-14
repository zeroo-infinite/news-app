module UserSummaries
  class WeeklyUserSummaryService
    def execute
      date = Date.today
      from = date.ago(7.days)
      to = date.yesterday
      users = User.where(role: "admin")
      users.each do |user|
        summaries = DailyUserSummary.where(date: from..to).where(user_id: user)
        next if summaries.empty?
        pv_count = 0
        comment_count = 0
        summaries.each do |summary|
          pv_count += summary.pv_count
          comment_count += summary.comment_count
        end
        WeeklyUserSummary.create!(
          user_id: user.id,
          pv_count: pv_count,
          comment_count: comment_count,
          start_date: from,
          end_date: to
        )
      end
    end
  end
end