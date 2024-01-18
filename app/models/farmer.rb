class Farmer < ApplicationRecord

  # Active_record associations

  belongs_to :user

  ###

  # Validate farmer's parameters
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true

end
