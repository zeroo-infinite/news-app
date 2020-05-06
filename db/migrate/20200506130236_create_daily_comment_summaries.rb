class CreateDailyCommentSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_comment_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :comment_count, null: false, default: 0
      t.date :date, null: false
      t.timestamps
    end
    create_table :weekly_comment_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :comment_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end

    create_table :monthly_comment_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :comment_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
