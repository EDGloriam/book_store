class CompleteForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :completed_order
  attr_reader :user

  def initialize(user, params = nil)
    @user = user
    @complete = false
    @completed_order = user.orders.in_progress[0]
  end

  def save
    @user.update_attribute(:complete_step, nil)
    @completed_order.update_attribute(:order_status, 'in_queue' )
    true
  end

  def has_completed?
    @complete
  end
end