module Admin
  module ArticleFilesHelper
    def is_image?(article_file)
      if Rails.env.production?
        image = MiniMagick::Image.open(article_file.file_url.url)
      else
        image = MiniMagick::Image.open(article_file.file_url.path)
      end
      image.valid?
    end
  end
end
