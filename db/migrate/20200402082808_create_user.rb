class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 191
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 0, limit: 2
      t.string :remember_digest
      t.datetime :remember_created_at
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :deleted_at
  end
end
