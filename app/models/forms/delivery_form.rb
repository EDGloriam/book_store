class DeliveryForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :types, :delivery

  def initialize(user, params = nil)
    @types = Delivery.all
    @user = user
    @param = params.nil? ? 0 : params[:delivery_id]
  end

  def save
    order = @user.orders.in_progress[0]
    # debugger
    order.update_attribute(:delivery_id,  @param)
    order.update_attribute(:total, add_delivery_to(order.total))

  end

  def add_delivery_to(value)
    delivery_price = Delivery.find(@param).price
    value + delivery_price
  end

end