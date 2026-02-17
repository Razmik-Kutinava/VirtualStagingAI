class TokenPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :token_package

  has_many :token_transactions, dependent: :destroy

  # Логирование покупки токенов
  after_create :log_token_purchase

  private

  def log_token_purchase
    AuditLogger.log(user, 'token_purchase', {
      purchase_id: id,
      package_id: token_package_id,
      package_name: token_package.name,
      tokens_amount: tokens_remaining,
      amount_cents: token_package.price_cents
    })
  end
end
