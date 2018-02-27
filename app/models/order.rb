class Order < ApplicationRecord
  ORDER_FILTERS_LIST = [nil, :in_progress, :in_queue, :in_delivery, :delivered, :canceled]
  enum order_status: ORDER_FILTERS_LIST[1, 5]

  belongs_to :credit_card, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  before_validation :update_subtotal, :update_total
  after_create :generate_number, :set_order_status

  scope :status, ->(status) { where order_status: status }
  scope :all_possible, -> { where.not(order_status: nil).where.not(order_status: :in_progress) }
  # scope :in_progress, -> {where(order_status: 'in_progress')}   # doesn't neeb, because  in_progress already exist(enum)

  def finalize
    update_subtotal
    update_total
  end

  def count_subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def display_name
    # for active_admin
  end

  def update_subtotal
    update_attribute(:subtotal, count_subtotal)
  end

  def update_total
    return update_attribute(:total, subtotal - recalculate_discount) if discount_applied
    update_attribute(:total, subtotal)
  end

  def apply_coupon(coupon)
    coupon.update_column(:used, true)
    update_attribute(:discount_applied, true)
    update_attribute(:discount, coupon.discount)
    update_total
  end

  def recalculate_discount
    discount_amount * subtotal
  end

  def add_order_item(order_item_params)
    current_item = order_items.find_by(book_id: order_item_params[:book_id])
    if current_item
      current_item.quantity += order_item_params[:quantity].to_i
    else
      current_item = order_items.build(order_item_params)
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
