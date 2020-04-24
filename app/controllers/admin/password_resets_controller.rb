module Admin
  class PasswordResetsController < Admin::BaseController
    skip_before_action :authorize_admin_user

    def new
    end

    def create
      @user = User.find_by(email: params[:password_reset][:email])
      if @user
        @user.create_reset_password_token
        PasswordResetMailerJob.perform_later(@user, @user.reset_password_token)
        redirect_to admin_login_path, notice: "パスワードをリセットするためのメールを送りました"
      else
        flash.now[:danger] = "入力いただいたメールアドレスは見つかりませんでした"
        render :new
      end
    end

    def edit
      @user = User.find_by(email: params[:email])
      redirect_to admin_login_path unless @user && @user.authenticated?(:reset_password_token, params[:id])
      redirect_to new_admin_password_reset_path, notice: "パスワードの有効期限がきれています" if @user.password_reset_expired?
    end

    def update
      @user = User.find_by(email: params[:email])
      redirect_to admin_login_path unless @user && @user.authenticated?(:reset_password_token, params[:id])
      redirect_to new_admin_password_reset_path, notice: "パスワードの有効期限がきれています" if @user.password_reset_expired?
      if params[:user][:password].empty?
        @user.errors.add(:password, :blank)
        render :edit
      elsif @user.update_attributes(user_params)
        log_in @user
        redirect_to root_path, notice: "パスワードをリセットしました"
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
