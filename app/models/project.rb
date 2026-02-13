class Project < ApplicationRecord
  belongs_to :user
  has_many :folders, dependent: :destroy
  has_many :images, dependent: :destroy

  enum :status, { active: 'active', archived: 'archived' }, default: 'active'

  validates :name, presence: true
end
