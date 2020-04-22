class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :article, type: :bigint, foreign_key: true, null: false
      t.text :comment, limit: 500, null: false
      t.timestamps
    end
  end
end
