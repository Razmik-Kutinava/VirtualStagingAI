class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :generation

  validates :user_id, uniqueness: { scope: :generation_id }
end
