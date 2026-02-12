class CreateTokenPackages < ActiveRecord::Migration[8.1]
  def change
    create_table :token_packages do |t|
      t.string :name
      t.integer :tokens_amount
      t.integer :price_cents
      t.integer :validity_days, default: 90
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
