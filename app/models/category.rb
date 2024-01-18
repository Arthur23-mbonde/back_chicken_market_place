class Category < ApplicationRecord

  # Active_record associations

  has_many :products, dependent: :destroy

  ###

  # Validate parameters for Category
  validates :name, presence: true, uniqueness: true

end
