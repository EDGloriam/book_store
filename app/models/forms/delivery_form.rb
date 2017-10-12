class DeliveryForm
  include ActiveModel::Model
  include Virtus

  attr_accessor :types, :delivery

  def initialize(user, params = nil)
    @types = Delivery.all
    @user = user
    @param = params.nil? ? 0 : params[:delivery_id]
  end

  def save
    order = @user.orders.in_progress[0]
    order.update(delivery_id: @param, total: inc(order.subtotal))
  end

  def inc(value)
    delivery_price = Delivery.find(@param).price
    value + delivery_price
  end

end