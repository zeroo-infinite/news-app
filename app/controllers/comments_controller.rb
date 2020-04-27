class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      redirect_to redirect_path, notice: "コメントを作成しました"
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def redirect_path
    if @article.category_id
      category_article_path(slug: @article.slug, category_name: @article.category.name, article_id: @article.id)
    else
      article_path(@article.slug, article_id: @article.id)
    end
  end
end
