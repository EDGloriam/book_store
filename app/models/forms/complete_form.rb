class CompleteForm
  include ActiveModel::Model
  include Virtus

  attr_accessor :completed_order

  def initialize(user, params = nil)
    @completed_order = user.orders.in_progress[0]
  end

  def save
    @completed_order.update_attribute(:order_status, 'in_queue' )
    true
  end

end