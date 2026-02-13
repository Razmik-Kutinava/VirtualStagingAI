class Folder < ApplicationRecord
  belongs_to :project
  has_many :images, dependent: :nullify

  validates :name, presence: true

  scope :ordered, -> { order(:sort_order, :created_at) }
end
