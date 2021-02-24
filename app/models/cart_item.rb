class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def sub_total_price
    (item.price * 1.1 * amount).round
  end


  validates :amount, presence: true, numericality: true
end