class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :deliveries
  has_many :cart_items, dependent: :destroy
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :phone_number, presence: true, format: {with: /\A\d{10,11}\z/}, numericality: true
  validates :postcode, presence: true, format: {with: /\A\d{7}\z/}, numericality: true
  validates :address, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def full_name
    last_name + first_name
  end

  def self.search_for(content, method)
    if method == 'forward'
      Customer.where('last_name LIKE ? OR first_name LIKE ?', content + '%',content + '%')
    elsif method == 'backward'
      Customer.where('last_name LIKE ? OR first_name LIKE ?', '%' + content,'%' + content)
    else
      Customer.where('last_name LIKE ? OR first_name LIKE ?', '%' + content + '%','%' + content + '%')
    end
  end

end
