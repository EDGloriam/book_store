class AddressStepForm
  require 'forms/address_form'

  include Virtus.model

  attribute :shipping, AddressForm
  attribute :billing, AddressForm

  def fill_with(params)
    debugger
    shipping(params)
    return true if shipping.valid? && billing.valid?
    false
  end

end
