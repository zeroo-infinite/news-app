module Admin
  class ArticleFilesController < ApplicationController
    def index
      @article_files = ArticleFile.order(created_at: :desc).page(params[:page])
    end

    def show
      @article_file = ArticleFile.find(params[:id])
    end

    def new
      @article_file = ArticleFile.new
    end

    def create
      @article_file = ArticleFile.new(article_file_params)
      @article_file.set_attributes
      if @article_file.save
        redirect_to admin_article_files_path, notice: "アップロードしました。"
      else
        render :new
      end
    end

    def edit
      @article_file = ArticleFile.find(params[:id])
    end

    def update
      @article_file = ArticleFile.find(params[:id])
      @article_file.attributes = article_file_params
      @article_file.set_attributes
      if @article_file.save
        redirect_to admin_file_path(@article_file.slug), notice: "再アップロードしました"
      else
        render :edit
      end
    end

    def destroy
      @article_file = ArticleFile.find(params[:id])
      @article_file.destroy!
      redirect_to admin_article_files_path, notice: "ファイルを削除しました"
    end

    private

    def article_file_params
      params.require(:article_file).permit(:name, :slug, :file_url)
    end
  end
end