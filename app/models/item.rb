class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  def add_tax_price
      (self.price_without_tax * 1.1).round
  end
end
