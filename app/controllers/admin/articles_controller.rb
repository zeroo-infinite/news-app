module Admin
  class ArticlesController < Admin::BaseController
    def index
      @form = Admin::Articles::SearchForm.new(search_params)
      articles = Article.all
      @articles = @form.search(articles ,params[:page])
    end

    def new
      @article = Article.new
    end

    def create
      @article = current_user.articles.build(article_params)
      if @article.save
        redirect_to articles_path, notice: "記事を作成しました"
      else
        render :new
      end
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
        redirect_to articles_path, notice: "記事を更新しました"
      else
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
        params.require(:article).permit(:title, :content, :slug, :image_url, :category_id, :status, :published_at)
      end

      def search_params
        params.fetch(:admin_articles_search_form, {}).permit(:status, :title, :category_id)
      end
  end
end