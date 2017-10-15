class Order < ApplicationRecord
  enum order_status: [:in_progress, :in_queue, :in_delivery, :delivered, :canceled]

  belongs_to :credit_card, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :order_items, dependent: :destroy

  before_validation :update_subtotal
  after_create :generate_number, :set_order_status

  # scope :in_progress, -> {where(order_status: 'in_progress')}   # doesn't neeb, because  in_progress already exist

  def subtotal
    puts "################################### Order.SUBTOTAL ###########################################"
    self.order_items.collect { |oi|  oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def add_book(book)
    puts "################################### Order.ADD BOOK ###########################################"
    current_item = order_items.find_by(book_id: book[:book_id])
    if current_item
      current_item.quantity += book[:quantity].to_i
    else
      current_item = order_items.build(book)
    end
    current_item
  end

  def apply_coupon(discount)
    puts "################################### Order.APPLY COUPON ###########################################"
    self.discount_amount = discount * self.subtotal
    self.discount_applied = true
    # self.save
  end

  def total
    puts "################################### Order.TOTAL ###########################################"
    return subtotal unless discount_applied
    subtotal - discount_amount
  end

private
  def generate_number
    self.update(number: "R#{(self[:id].to_i + 100220000)}")
  end

  def set_order_status
    puts "################################### Order.SET ORDER STATUS ###########################################"
    self.in_progress! if order_status.nil?
  end

  def update_subtotal
    puts "###################################Order.UPDATE SUBTOTAL###########################################"
    self.subtotal = subtotal
  end
end
