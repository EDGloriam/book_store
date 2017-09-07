class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  validate :order_present

  before_save :finalize

private
  def book_present
    puts "=================book_present========="
    if book.nil?
      errors.add(:book, "is not valid or is not active.")
    end
  end

  def order_present
    puts "=================order_present========="
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    puts "=================finalize========="
    self.unit_price = book.price
    self.total_price = self.quantity * self.unit_price
  end
end
