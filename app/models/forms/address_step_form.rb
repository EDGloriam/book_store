class AddressStepForm
  require 'forms/address_form'
  include ActiveModel::Model
  include Virtus.model

  attribute :shipping, AddressForm
  attribute :billing, AddressForm
  attribute :user, User

  def initialize(params = {})
    if params.has_key?(:user)
      @shipping =  AddressForm.new( params[:user][:shipping] )
      @billing =  AddressForm.new( params[:user][:billing] )
    else
      @shipping =  AddressForm.new()
      @billing =  AddressForm.new()
    end
  end

  # def save
  #   @shipping. if @shipping.valid?

  #   @billing
  #   shipping(params)

  # end

end
