class AddColumnArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :status, :integer, default: 0
    add_column :articles, :published_at, :datetime
  end
end
