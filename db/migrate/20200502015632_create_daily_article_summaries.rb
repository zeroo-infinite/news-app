class CreateDailyArticleSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_article_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.integer :comment_count, null: false, default: 0
      t.date :date, null: false
      t.timestamps
    end

    create_table :weekly_article_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.integer :comment_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end

    create_table :monthly_article_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.integer :comment_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end

    add_column :articles, :pv_count, :integer, null: false, default: 0
  end
end
