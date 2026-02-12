class Style < ApplicationRecord
  has_many :generations, dependent: :destroy
end
