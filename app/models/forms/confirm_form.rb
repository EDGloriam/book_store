class ConfirmForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :shipping_address, :billing_address, :shipment, :payment

  def initialize(user, params = nil)
    @shipment = user.orders.in_progress[0].delivery
    @shipping_address = user.shipping_address
    @billing_address = user.billing_address
    @payment = user.orders.in_progress[0].credit_card
  end

  def save
    true
  end

end