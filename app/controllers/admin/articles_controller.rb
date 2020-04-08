class Admin::ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = @current_user.articles.build(article_params)
    if @article.save
      redirect_to articles_path, notice: "記事を作成しました"
    else
      flash.now[:danger] = "記事の作成に失敗しました"
      render :new
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :slug, :image_url)
    end
end
