class AddressForm
  include ActiveModel::Model
  include Virtus.model

  attr_accessor :billing
  attr_accessor :shipping
  attr_accessor :billing_valid, :shipping_valid
  attr_accessor :complete

  def initialize(user, params = nil)
    @billing = user.find_or_init(:billing_address)
    @shipping = user.find_or_init(:shipping_address)
    # @complete = false

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

  def has_completed?
    @complete
  end

end