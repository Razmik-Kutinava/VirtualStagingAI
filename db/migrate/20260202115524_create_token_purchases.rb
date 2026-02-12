class CreateTokenPurchases < ActiveRecord::Migration[8.1]
  def change
    create_table :token_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :token_package, null: false, foreign_key: true
      t.integer :tokens_remaining
      t.datetime :purchased_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
