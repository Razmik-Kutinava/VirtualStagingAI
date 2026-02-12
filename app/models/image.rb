class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  has_many :input_generations, class_name: "Generation", foreign_key: "input_image_id", dependent: :destroy
  has_one :output_generation, class_name: "Generation", foreign_key: "output_image_id", dependent: :destroy

  enum :kind, { input: "input", output: "output" }
  
  # Количество стилей для этого изображения
  def styles_count
    input_generations.succeeded.count
  end
  
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }
end
