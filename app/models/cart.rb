class Cart < ApplicationRecord

  # Active_record associations

  has_many :cart_products
  has_many :products, through: :cart_products

  ###

  # Define total sum of the products which are presents in the shopping cart
  def total
    cart_products.to_a.sum { |cart_product| cart_product.total }
  end

end
