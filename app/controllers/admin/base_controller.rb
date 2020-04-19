class Admin::BaseController < ApplicationController
  include SessionsHelper
  before_action :authorize_admin_user
  layout "admin"

  private

  def authorize_admin_user
    unless current_user&.admin?
      store_location
      redirect_to admin_login_path
    end
  end
end