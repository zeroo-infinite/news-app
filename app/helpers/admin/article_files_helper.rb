module Admin
  module ArticleFilesHelper
    def is_image?(article_file)
      image = MiniMagick::Image.new(article_file.file_url.file.file)
      image.valid?
    end
  end
end
