module Ranking
  module Users
    class CommentSearchForm
      include ActiveModel::Model
      attr_accessor :term

      def initialize(args = {})
        @term = args[:term]
      end

      def search
        # date = Date.yesterday
        date = Date.new(2019, 11, 30)
        model = find_term_model
        summaries = model.top_comment_summaries(date)
        summaries.map { |summary| summary.user }
      end

      private

      def find_term_model
        case @term
        when "daily"
          DailyUserSummary
        when "weekly"
          WeeklyUserSummary
        when "monthly"
          MonthlyUserSummary
        else
          DailyUserSummary
        end
      end
    end
  end
end