class CheckOutPagesController < ApplicationController
  require 'form/address_form'
  before_action :authenticate_user!
  before_action :set_order
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete


  def show
    @form = AddressForm.new(current_user)
    render_wizard
  end


  def update
    # debugger
    @form = form_object.new(current_user, permitted_params)
    render_wizard @form
    puts "#{@form}=================================="
  end



  def form_object
    case step
      when :address then AddressForm

      end
  end

  private

    def permitted_params
      params.require(:address_form).permit(:billing_first_name, :billing_last_name, :billing_address, :billing_city, :billing_zip, :billing_сountry, :billing_phone, :shipping_first_name, :shipping_last_name,  :shipping_address,  :shipping_city,  :shipping_zip, :shipping_сountry, :shipping_phone)
    end
end
