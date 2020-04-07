class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def ensure_admin_user
      respond_with_error(404) unless current_user&.admin?
    end

    def respond_with_error(code)
      render file: Rails.root.join("public/#{code}.html"), status: code, layout: false, content_type: "text/html"
    end
end
