class CreateTokenTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :token_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :token_purchase, null: true, foreign_key: true
      t.references :generation, null: true, foreign_key: true
      t.string :operation
      t.integer :amount

      t.timestamps
    end
  end
end
