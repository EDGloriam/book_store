class AddressStepForm
  require 'forms/address_form'
  include ActiveModel::Model
  include Virtus.model

  attribute :shipping, AddressForm
  attribute :billing, AddressForm

  def initialize(user, params = {})
    # debugger
    params.merge!(user: user)

    @shipping = AddressForm.new(params, :shipping)
    @billing = AddressForm.new(params, :billing)

    # @billing.set_user(user)
    # @shipping.set_user(user)

  end

  # def find_or_init(address)
  #   @user.send("#{address}_address") || AddressForm.new(user: @user)
  # end

  def save
   shipping.save && billing.save
  end

end
