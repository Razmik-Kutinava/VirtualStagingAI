class TokenPackage < ApplicationRecord
  has_many :token_purchases, dependent: :destroy
  has_many :payments, dependent: :destroy
end
