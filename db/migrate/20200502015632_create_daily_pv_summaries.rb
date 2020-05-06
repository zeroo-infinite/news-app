class CreateDailyPvSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_pv_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.date :date, null: false
      t.timestamps
    end

    create_table :weekly_pv_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end

    create_table :monthly_pv_summaries do |t|
      t.references :article, type: :bigint, null: false
      t.integer :pv_count, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end

    add_column :articles, :pv_count, :integer, null: false, default: 0
  end
end
