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
  end



  def form_object
    case step
      when :address then AddressForm

      end
  end

  private

    def permitted_params
      params.require(:user).permit(:billing_address => Address::ADDRESS_ATTRIBUTES,
        :shipping_address => Address::ADDRESS_ATTRIBUTES )
    end
end
