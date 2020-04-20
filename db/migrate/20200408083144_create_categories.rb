class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 191
      t.integer :pv_count, null: false, default: 0
      t.timestamps
    end
    add_index :categories, :name, :unique => true

    add_reference :articles, :category, foreign_key: true
  end
end
