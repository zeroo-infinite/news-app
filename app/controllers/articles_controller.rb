class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:category).order_created_at_desc.page(params[:page])
  end

  def show
    @article = Article.find_by!(slug: params[:slug])
  end
end
