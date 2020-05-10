module Ranking
  class ArticlesController < ApplicationController
    def comment
      @form = Ranking::Articles::CommentSearchForm.new(search_params)
      @articles = @form.search
      @categories = Category.all
    end

    def pv
      @form = Ranking::Articles::PvSearchForm.new(search_params)
      @articles = @form.search
      @categories = Category.all
    end

    private

      def search_params
        params.permit(:term, :category_name)
      end
  end
end