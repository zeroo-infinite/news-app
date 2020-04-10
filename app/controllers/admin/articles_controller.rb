class Admin::ArticlesController < ApplicationController
  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      @article.create_article_categorization!(category_id: params[:article][:category_id]) if params[:article][:category_id].present?
      redirect_to articles_path, notice: "記事を作成しました"
    else
      flash.now[:danger] = "記事の作成に失敗しました"
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      @article.create_article_categorization!(category_id: params[:article][:category_id]) if params[:article][:category_id].present?
      redirect_to articles_path, notice: "記事を更新しました"
    else
      flash.now[:danger] = "記事の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to articles_path, notice: "記事を削除しました"
    else
      flash.now[:danger] = "記事の削除に失敗しました"
      render :edit
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :slug, :image_url)
    end
end
