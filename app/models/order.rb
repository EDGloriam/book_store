class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_status
  has_many :order_items, dependent: :destroy

  before_validation :set_order_status
  before_validation :update_subtotal
  after_create :generate_order_number

  def subtotal
    self.order_items.collect { |oi|  oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def add_book(book)
    current_item = order_items.find_by(book_id: book[:book_id])
    if current_item
      current_item.quantity += book[:quantity].to_i
    else
      current_item = order_items.build(book)
    end
    current_item
  end

private
  def generate_order_number
    self.number= "R#{(self[:id]+100220000)}"
  end

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self.subtotal = subtotal
  end
end
