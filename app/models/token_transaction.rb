class TokenTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :token_purchase, optional: true
  belongs_to :generation, optional: true
end
