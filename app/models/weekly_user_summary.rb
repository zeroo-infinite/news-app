class WeeklyUserSummary < ApplicationRecord
  belongs_to :user

  scope :top_pv_summaries, ->(date) { includes(:user).where(end_date: date).order(pv_count: :desc).limit(10) }
  scope :top_comment_summaries, ->(date) { includes(:user).where(end_date: date).order(comment_count: :desc).limit(10) }
end
