class AddTokensSpentToGenerations < ActiveRecord::Migration[8.1]
  def change
    add_column :generations, :tokens_spent, :integer, default: 1, null: false
  end
end
