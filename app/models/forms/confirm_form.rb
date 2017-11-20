class ConfirmForm
  attr_accessor :shipping_address, :billing_address, :shipment, :payment
  attr_reader :user

  def initialize(user, params = nil)
    @user = user
    @complete = false
    @shipment = user.orders.in_progress[0].delivery
    @shipping_address = user.shipping_address
    @billing_address = user.billing_address
    @payment = user.orders.in_progress[0].credit_card
  end

  def save
    @user.update_attribute(:complete_step, 'confirm')
    true
  end
end
