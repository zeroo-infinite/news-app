class Admin::BaseController < ApplicationController
  include SessionsHelper

  private

  def authorize_admin_user
    redirect_to admin_login_path unless current_user&.admin?
  end
end