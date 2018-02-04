class AddressStepForm
  require 'forms/address_form'
  include ActiveModel::Model
  include Virtus.model

  attribute :shipping, AddressForm
  attribute :billing, AddressForm

  def initialize(user, params = {})
    params.merge!(user: user)
    shipping = AddressForm.new(params, :shipping)
    billing = AddressForm.new(params, :billing)
  end

  def save
   shipping.save && billing.save
  end

end
