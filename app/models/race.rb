class Race < ApplicationRecord

  # Active_record associations

  has_many :products, dependent: :destroy

  ###

  # Vaalidate race's parameter
  validates :name, presence: true, uniqueness: true

end
