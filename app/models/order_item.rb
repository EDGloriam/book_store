class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  before_save :finalize


private
  def book_present
    errors.add(:book, 'is not valid or is not active.') if book.nil?
  end

  def order_present
    errors.add(:order, 'is not a valid order.') if order.nil?
  end

  def finalize
    self.unit_price = book.price #self == #<OrderItem id: nil, book_id: 6, order_id: 9, unit_price: nil, quantity: 1...
    self.total_price = self.quantity * self.unit_price
  end
end
