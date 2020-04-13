module Admin
  class ArticleFilesController < ApplicationController
    def index
      @article_files = ArticleFile.order(created_at: :desc).page(params[:page])
    end

    def show
      @article_file = ArticleFile.find_by(slug: params[:slug])
    end

    def new
      @article_file = ArticleFile.new
    end

    def create
      @article_file = ArticleFile.new(article_file_params)
      if @article_file.save
        redirect_to admin_article_files_path, notice: "アップロードしました。"
      else
        render :new
      end
    end


    private

    def article_file_params
      params.require(:article_file).permit(:name, :slug, :file_url)
    end
  end
end