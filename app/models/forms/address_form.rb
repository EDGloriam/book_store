class AddressForm
  attr_accessor :billing, :shipping, :billing_valid, :shipping_valid
  def initialize(user, params = nil)
    @billing = user.find_or_init(:billing_address)
    @shipping = user.find_or_init(:shipping_address)

    @billing.update(params[:billing_address]) if params
    @shipping.update(params[:shipping_address]) if params
  end

  def save
    @billing_valid = @billing.save
    @shipping_valid = @shipping.save
    return false unless @billing_valid && @shipping_valid
    @billing.user.update_attribute(:complete_step, 'address')
    true
  end
end
