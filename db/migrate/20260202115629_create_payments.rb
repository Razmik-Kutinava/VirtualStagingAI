class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :token_package, null: false, foreign_key: true
      t.integer :amount_cents
      t.string :currency, default: "RUB"
      t.string :status, default: "pending"
      t.string :cloudpayments_transaction_id
      t.string :cloudpayments_invoice_id
      t.string :card_type
      t.string :card_last_four
      t.datetime :paid_at
      t.json :metadata

      t.timestamps
    end

    add_index :payments, :cloudpayments_transaction_id, unique: true
  end
end
