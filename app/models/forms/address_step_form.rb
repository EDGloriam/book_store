class AddressStepForm
  # require 'forms/billing_form'
  # require 'forms/shipping_form'
  require 'forms/address_form'

  include Virtus.model

  attribute :shipping, AddressForm
  attribute :billing, AddressForm
end
