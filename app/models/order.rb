class Order < ApplicationRecord
  enum order_status: [:in_progress, :in_queue, :in_delivery, :delivered, :canceled]

  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  before_validation :update_subtotal
  after_create :generate_number, :set_order_status

  scope :in_progress, -> {where(status_order: 'in_progress')}

  def subtotal
    self.order_items.collect { |oi|  oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
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

private
  def generate_number
    puts "==========SETUPING NUMBER==============="
    self.update(number: "R#{(self[:id].to_i + 100220000)}")
  end

  def set_order_status
    # debugger
    puts "==========SETUPING STATUS==============="
    self.in_progress! if order_status.nil?
  end

  def update_subtotal
    puts "==========UP S U B T O T A L==============="
    self.subtotal = subtotal
  end
end
