class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  validates :select_address, acceptance: true

  with_options presence: true do
    validates :address, length: {maximum: 20, minimum: 2}
    validates :postcode, format: {with: /\A\d{7}\z/}, numericality: true
    validates :name
    validates :postage
    validates :total_payment
    validates :payment_method
    validates :status
  end


  enum status: { "入金待ち": 0, "入金確認": 1, "制作中": 2, "発送準備中":3, "発送済み":4 }
end