module Ranking
  class PvController < ApplicationController
    def index
      @form = Ranking::PvSearchForm.new(search_params)
      @articles = @form.search
      @category = Category.all
    end

    private

      def search_params
        params.fetch(:ranking_pv_search_form, {}).permit(:term)
      end
  end
end