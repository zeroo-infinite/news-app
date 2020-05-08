module Ranking
  module Articles
    class PvSearchForm
      include ActiveModel::Model
      attr_accessor :term

      def initialize(args = {})
        @term = args[:term]
      end

      def search
        date = Date.yesterday
        model = find_term_model
        summaries = model.top_pv_summaries(date)
        summaries.map { |summary| summary.article }
      end

      private

        def find_term_model
          case @term
          when "daily"
            DailyArticleSummary
          when "weekly"
            WeeklyArticleSummary
          when "monthly"
            MonthlyArticleSummary
          else
            DailyArticleSummary
          end
        end
    end
  end
end