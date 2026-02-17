class Generation < ApplicationRecord
  belongs_to :user
  belongs_to :input_image, class_name: "Image"
  belongs_to :output_image, class_name: "Image", optional: true
  belongs_to :style

  has_many :favorites, dependent: :destroy
  has_many :token_transactions, dependent: :destroy

  enum :status, { 
    queued: "queued", 
    running: "running", 
    succeeded: "succeeded", 
    failed: "failed",
    cancelled: "cancelled"
  }

  validates :tokens_spent, presence: true, numericality: { greater_than: 0 }

  # Логирование создания генерации
  after_create :log_generation_created

  private

  def log_generation_created
    AuditLogger.log(user, 'generation_created', {
      generation_id: id,
      input_image_id: input_image_id,
      style_id: style_id,
      tokens_spent: tokens_spent,
      status: status
    })
  end
end
