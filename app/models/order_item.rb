class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :book, presence: { message: 'is not valid or is not active.' }
  validates :order, presence: { message: 'is not a valid order.' }
  before_save :finalize


private

  # def order_present                                                -> validates :order
  #   errors.add(:order, 'is not a valid order.') if order.nil?
  # end

  def finalize
    self.unit_price = book.price #self == #<OrderItem id: nil, book_id: 6, order_id: 9, unit_price: nil, quantity: 1...
    self.total_price = self.quantity * self.unit_price
  end
end
