class AddressForm

  include ActiveModel::Model
  include Virtus

  def initialize(user, params = nil)
    current_billing = user.build_billing_address
    current_shipping = user.shipping_address
    unless current_billing
      @billing = user.build_billing_address(params)
    else
      get_billing
    end
    unless current_shipping
      @shipping = user.build_shipping_address(params)
    else
      get_shipping
    end

    debugger
  end

  # attr_accessor :billing_first_name
  # attr_accessor :billing_last_name
  # attr_accessor :billing_address
  # attr_accessor :billing_city
  # attr_accessor :billing_zip
  # attr_accessor :billing_сountry
  # attr_accessor :billing_phone

  # attr_accessor :shipping_first_name
  # attr_accessor :shipping_last_name
  # attr_accessor :shipping_address
  # attr_accessor :shipping_city
  # attr_accessor :shipping_zip
  # attr_accessor :shipping_сountry
  # attr_accessor :shipping_phone

  def save
    return false unless valid?


    true
  end

  private
    def get_billing
      @billing = user.billing_address
    end

    def get_shipping
      @shipping = user.shipping_address
    end
end