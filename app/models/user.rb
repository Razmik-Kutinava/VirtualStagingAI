class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :projects, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :generations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :token_purchases, dependent: :destroy
  has_many :token_transactions, dependent: :destroy
  has_many :payments, dependent: :destroy

  # Подсчет баланса токенов
  def token_balance
    # Бессрочные покупки (expires_at = NULL) и активные покупки (expires_at > текущее время)
    active_purchases = token_purchases.where("expires_at IS NULL OR expires_at > ?", Time.current)
    total_purchased = active_purchases.sum(:tokens_remaining) || 0
    total_spent = token_transactions.where(operation: "spend").sum(:amount) || 0
    total_purchased - total_spent
  end
end
