class ApplicationController < ActionController::Base
  if Rails.env.production?
    rescue_from Exception, with: :render_500
    rescue_from AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def render_404(e = nil)
    logger.error "Rendering 404 with exception: #{e.class.name} (#{e.message})" if e
    render file: Rails.root.join("public/errors/404.html"), status: 404, layout: false, content_type: 'text/html', formats: [:html]
  end

  def render_500(e = nil)
    if e
      logger.error "Rendering 500 with exception: #{e.class.name} (#{e.message})"
      logger.error e.backtrace.inspect
    end
    render file: Rails.root.join("public/errors/500.html"), status: 500, layout: false, content_type: 'text/html', formats: [:html]
  end
end
