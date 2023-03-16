class CartItem < ApplicationRecord
  belongs_to :end_user
  belongs_to :item
  validates :amount, presence: true

  def subtotal
    item.add_tax_price * amount
  end
end
