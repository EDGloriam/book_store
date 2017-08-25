class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    self.order_items.collect do |oi|
      puts "oi-VALID #{oi.valid?}"
      oi.valid? ? (oi.quantity * oi.unit_price) : 0
    end.sum
  end

private
  def set_order_status                       #why this doesnt work
    order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
