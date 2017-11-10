class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :book, presence: { message: 'is not valid or is not active.' }
  validates :order, presence: { message: 'is not a valid order.' }
  # before_update :check_quantity, if: :quantity_changed?
  before_save :finalize

private

  # def check_quantity
  #   if order_item_params[:quantity].present?
  #     order_item.update(quantity: order_item_params[:quantity])
  #   else
  #     quantity = order_item.quantity.to_i
  #     order_item.quantity = quantity + order_item_params[:change_quantity].to_i
  #     order_item.quantity = 1 if order_item.quantity <= 1
  #     order_item.save
  #   end
  # end

  # def order_present                                                -> validates :order
  #   errors.add(:order, 'is not a valid order.') if order.nil?
  # end

  def finalize
    self.unit_price = book.price #self == #<OrderItem id: nil, book_id: 6, order_id: 9, unit_price: nil, quantity: 1...
    self.total_price = self.quantity * self.unit_price
  end
end
