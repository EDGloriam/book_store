class CheckOutPagesController < ApplicationController
  require 'forms/address_form'
  require 'forms/delivery_form'
  require 'forms/payment_form'
  require 'forms/confirm_form'
  require 'forms/complete_form'

  before_action :return_after_signed_in, unless: :user_signed_in?
  before_action :authenticate_user!
  before_action :set_order
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete


  def show
    return redirect_to finish_wizard_path if step == Wicked::FINISH_STEP
    @form_object = form_model.new(current_user)
    step_in_order
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
    def step_in_order
      current_step = current_user.complete_step
      if current_step.nil?
        current_user.update_attribute(:complete_step, step.to_s)
        jump_to(steps.first)
      else
        desired_step_index = steps.index(step) #delivery => 1
        actual_step_index = steps.index(current_step.to_sym)+1
        puts ">>>>>>>>>>>>>>>>>>>>#{current_step}"
        puts ">desired_step_index>>>>>>>>>>>>>>>>>>>#{desired_step_index}"
        puts ">actual_step_index>>>>>>>>>>>>>>>>>>>#{actual_step_index}"
          jump_to(steps[actual_step_index]) if desired_step_index > actual_step_index
      end

    end

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

    #this needs because jQuery mask adds spase to number
    def payment_params
      param = params.require(:credit_card).permit(:number, :name, :mmyy, :cvv)
      param[:number].delete!(' ')
      param
    end
end
