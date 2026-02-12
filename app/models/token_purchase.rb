class TokenPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :token_package

  has_many :token_transactions, dependent: :destroy
end
