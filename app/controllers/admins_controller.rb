class AdminsController < ApplicationController
  def new
    @admin = User.new
  end

  def create
    @admin = User.new(admin_params)
    if @admin.save
      redirect_to admins_path, notice: "ユーザを登録しました"
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end

  private

    def admin_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end
