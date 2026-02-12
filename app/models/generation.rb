class Generation < ApplicationRecord
  belongs_to :user
  belongs_to :input_image, class_name: "Image"
  belongs_to :output_image, class_name: "Image", optional: true
  belongs_to :style

  has_many :token_transactions, dependent: :destroy

  enum :status, { queued: "queued", running: "running", succeeded: "succeeded", failed: "failed" }
end
