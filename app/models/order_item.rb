class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  before_save :finalize


private
  def book_present
    puts "################################### OI BOOK.PRESENT ###########################################"
    if book.nil?
      errors.add(:book, "is not valid or is not active.")
    end
  end

  def order_present
     puts "################################### OI ORDER.PRESENT ###########################################"
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    # debugger
     puts "################################### OI BOOK.FINALIZE ###########################################"
    self.unit_price = book.price #self == #<OrderItem id: nil, book_id: 6, order_id: 9, unit_price: nil, quantity: 1...
    self.total_price = self.quantity * self.unit_price
  end
end
