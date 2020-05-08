module Ranking
  class UsersController < ApplicationController
    def comment
      @form = Ranking::Users::CommentSearchForm.new(comment_search_params)
      @users = @form.search
    end

    def pv
      @form = Ranking::Users::PvSearchForm.new(pv_search_params)
      @users = @form.search
    end

    private

      def pv_search_params
        params.fetch(:ranking_users_pv_search_form, {}).permit(:term)
      end

      def comment_search_params
        params.fetch(:ranking_users_comment_search_form, {}).permit(:term)
      end
  end
end