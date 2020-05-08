module Ranking
  class ArticlesController < ApplicationController
    def comment
      @form = Ranking::Articles::CommentSearchForm.new(comment_search_params)
      @articles = @form.search
      @category = Category.all
    end

    def pv
      @form = Ranking::Articles::PvSearchForm.new(pv_search_params)
      @articles = @form.search
      @category = Category.all
    end

    private

      def pv_search_params
        params.fetch(:ranking_pv_search_form, {}).permit(:term)
      end

      def comment_search_params
        params.fetch(:ranking_comment_search_form, {}).permit(:term)
      end
  end
end