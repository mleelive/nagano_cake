class Item < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items

  attachment :image
  
  def self.search_for(content, method)
    if method == 'forward'
      Item.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Item.where('name LIKE ?', '%'+content)
    else
      Item.where('name LIKE ?', '%'+content+'%')
    end
  end

 with_options presence: true do
    validates :image
    #validates :category_id
    validates :name, length: {maximum: 20, minimum: 1}
    validates :information
    validates :price, numericality: true
  end

end
