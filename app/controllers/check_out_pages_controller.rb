class CheckOutPagesController < ApplicationController
  require 'forms/address_form'
  require 'forms/delivery_form'
  require 'forms/payment_form'
  require 'forms/confirm_form'
  require 'forms/complete_form'
  # debugger
  before_action :return_after_signed_in, unless: :user_signed_in?
  before_action :authenticate_user!
  before_action :set_order
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete


  def show
    return redirect_to finish_wizard_path if step == Wicked::FINISH_STEP
    @form_object = form_model.new(current_user)
    render_wizard
  end


  def update
    @form_object = form_model.new(current_user, permitted_params)
    cookies.delete :order_id if step == :complete
    render_wizard @form_object
  end

  def finish_wizard_path
    books_path
  end

  def form_model
    case step
      when :address then AddressForm
      when :delivery then DeliveryForm
      when :payment then PaymentForm
      when :confirm then ConfirmForm
      when :complete then CompleteForm
    end
  end

  private
    def return_after_signed_in
      cookies[:checkout] = true
    end

    def permitted_params
      return nil if [:confirm, :complete ,:wicked_finish].include? step
      return payment_params if step == :payment
      return params.require(:order).permit(:delivery_id) if step == :delivery
      params.require(:user).permit(:billing_address => Address::ADDRESS_ATTRIBUTES,
        :shipping_address => Address::ADDRESS_ATTRIBUTES )
    end

    def payment_params
      param = params.require(:credit_card).permit(:number, :name, :mmyy, :cvv)
      param[:number].delete!(' ')
      param
    end
end
