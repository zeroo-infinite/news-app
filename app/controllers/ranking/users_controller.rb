module Ranking
  class UsersController < ApplicationController
    def comment
      @form = Ranking::Users::CommentSearchForm.new(search_params)
      @users = @form.search
    end

    def pv
      @form = Ranking::Users::PvSearchForm.new(search_params)
      @users = @form.search
    end

    private

      def search_params
        params.permit(:term)
      end
  end
end