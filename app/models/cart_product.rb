class CartProduct < ApplicationRecord

  # Active_record associations

  belongs_to :product
  belongs_to :cart

  ###

  # Calculate a total sum of a specific product in the shopping cart
  def total
    product.current_price * rate
  end

end
