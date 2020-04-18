class CreateArticleHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :article_histories do |t|
      t.references :user, type: :bigint, null: false
      t.references :article, type: :bigint, null: false
      t.references :category, type: :bigint
      t.integer :change_type, null: false
      t.string :title, limit: 100
      t.string :content
      t.string :slug
      t.string :image_url
      t.integer :status
      t.datetime :released_at
      t.timestamps
    end
  end
end
