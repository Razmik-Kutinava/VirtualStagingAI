class MakeExpiresAtNullableInTokenPurchases < ActiveRecord::Migration[8.1]
  def change
    change_column_null :token_purchases, :expires_at, true
  end
end
