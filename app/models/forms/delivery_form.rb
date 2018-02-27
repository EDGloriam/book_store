class DeliveryForm
  attr_accessor :types, :delivery
  attr_reader :user

  def initialize(user, params = nil)
    @complete = false
    @types = Delivery.all
    @user = user
    @param = params.nil? ? 0 : params[:delivery_id]
  end

  def save
    @complete = true
    order = @user.orders.in_progress[0]
    @user.update_attribute(:complete_step, 'delivery')
    order.update_attribute(:delivery_id,  @param)
    order.update_attribute(:total, add_delivery_to(order.total))

  end

  def add_delivery_to(value)
    delivery_price = Delivery.find(@param).price
    value + delivery_price
  end
end
