class TokenPackage < ApplicationRecord
  has_many :token_purchases, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, presence: true
  validates :tokens_amount, presence: true, numericality: { greater_than: 0 }
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(active: true) }
  scope :ordered_by_price, -> { order(:price_cents) }

  # Вычисление цены за токен в долларах
  def price_per_token
    return 0 if tokens_amount.zero?
    (price_cents.to_f / tokens_amount / 100.0).round(2)
  end

  # Цена в долларах
  def price_dollars
    price_cents / 100.0
  end
end

