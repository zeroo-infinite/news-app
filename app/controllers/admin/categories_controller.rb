class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "カテゴリーを作成しました"
    else
      flash.now[:danger] = "カテゴリーの作成に失敗しました"
      render :new
    end
  end


  private

    def category_params
      params.require(:category).permit(:name)
    end
end
