class ArticleFile < ApplicationRecord
  validates :name, null: false, length: { in: 1..100 }, presence: true
  validates :slug, null: false, length: { in: 1..100 }, uniqueness: true
  validates :file_url, null: false
  paginates_per 10
  mount_uploader :file_url, ArticleFileUploader

  def set_attributes
    self.file_type = File.extname(self.file_url.identifier)
    self.file_size = File.stat(self.file_url.file.file).size
    image = MiniMagick::Image.new(self.file_url.file.file)
    if image.valid?
      self.data = { "width": image[:width], "height": image[:height] }
    end
  end
end
