class Order < ApplicationRecord
  ORDER_FILTERS_LIST =  [nil, :in_progress, :in_queue, :in_delivery, :delivered, :canceled]
  enum order_status: ORDER_FILTERS_LIST[1, 5]

  belongs_to :credit_card, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :order_items, dependent: :destroy

  before_validation :update_subtotal, :update_total
  after_create :generate_number, :set_order_status


  scope :status, -> (status) { where order_status: status }
  # scope :in_progress, -> {where(order_status: 'in_progress')}   # doesn't neeb, because  in_progress already exist(enum)

  def count_subtotal
    self.order_items.collect { |oi|  oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

  def display_name
    #for active_admin
  end

  def update_subtotal
    update_attribute(:subtotal, count_subtotal)
  end

  def update_total
    return update_attribute(:total, subtotal - recalculate_discount) if discount_applied
    update_attribute(:total, subtotal)
  end

  def apply_coupon(discount)
    update_attribute(:discount_applied, true)
    update_attribute(:discount_amount, discount)
    update_total
  end

  def recalculate_discount
    discount_amount * subtotal
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

  def generate_number
    update_attribute(:number, "R#{(self[:id].to_i + 100220000)}")
  end

  def set_order_status
    self.in_progress! if order_status.nil?
  end
end
