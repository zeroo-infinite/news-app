class ArticleFile < ApplicationRecord
  validates :name, length: { in: 1..100 }, presence: true
  validates :slug, presence: true, length: { in: 1..100 }, uniqueness: true
  validates :file_url, presence: { message: "を選択してください" }
  paginates_per 10
  mount_uploader :file_url, ArticleFileUploader

  def set_file_info
    self.file_type = File.extname(self.file_url.identifier)
    self.file_size = self.file_url.size
    if Rails.env.production?
      image = MiniMagick::Image.open(self.file_url.url)
    else
      image = MiniMagick::Image.open(self.file_url.path)
    end
    if image.valid?
      self.data = { "width": image[:width], "height": image[:height] }
    end
  end
end
