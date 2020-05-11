class CreateUserSummaryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "create_user_summary", retry: false

  def perform
    daily_summary = UserSummaries::DailyUserSummaryService.new
    daily_summary.summary
    weekly_summary = UserSummaries::WeeklyUserSummaryService.new
    weekly_summary.summary
    monthly_summary = UserSummaries::MonthlyUserSummaryService.new
    monthly_summary.summary
  end
end