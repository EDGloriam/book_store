class Order < ApplicationRecord

  belongs_to :order_status
  has_many :order_items
  before_validation :set_order_status
  before_validation :update_subtotal
  before_validation :generate_order_number

  def subtotal
    self.order_items.collect { |oi| puts "oi-VALID #{oi.valid?}"; oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

private
  def generate_order_number
    self.number = "R#{(self[:id]+100550000)}"
  end

  def set_order_status
    puts "WORKS"                 #why this doesnt work
    self.order_status_id = 1
  end

  def update_subtotal
    puts "============update_subtotal==========="
    self.subtotal = subtotal
  end
end
