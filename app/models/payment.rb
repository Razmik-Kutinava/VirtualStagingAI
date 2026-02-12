class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :token_package

  enum :status, { pending: "pending", succeeded: "succeeded", failed: "failed" }
end
