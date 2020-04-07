class AdminsController < ApplicationController
  def index
    @admin_users = User.where(role: 1)
  end

  def show
    @admin_user = User.find(params[:id])
  end

  def new
    @admin_user = User.new
  end

  def create
    @admin_user = User.new(admin_params)
    if @admin_user.save
      redirect_to admins_path, notice: "ユーザを登録しました"
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end

  def edit
    @admin_user = User.find(params[:id])
  end

  def update
    @admin_user = User.find(params[:id])
    if @admin_user.update(admin_params)
      redirect_to admin_path, notice: "ユーザの情報を更新しました"
    else
      flash.now[:danger] = "ユーザの情報更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @admin_user = User.find(params[:id])
    if @admin_user.destory
      redirect_to admins_path, notice: "ユーザの情報を削除しました"
    else
      flash.now[:alert] = "ユーザの情報削除に失敗しました"
      render :show
    end
  end

  private

    def admin_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end
