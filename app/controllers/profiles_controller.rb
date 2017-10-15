class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_current_user
  def show
    @billing_address = @user.find_or_init(:billing_address)
    @shipping_address = @user.find_or_init(:shipping_address)
  end

  def update
    address_type = params[:user].keys[0]
    if @user.send(address_type).nil?
      @user.send("build_#{address_type}".to_sym, permitted_params(address_type))
    else
      @user.send(address_type).update(permitted_params(address_type))
    end

    address = @user.send(address_type)
    if address.save
      redirect_to settings_path
    else
      instance_variable_set("@#{address.class.name.underscore}", address)
      instance_variable_set("@#{next_address(address_type)}", @user.find_or_init(next_address(address_type.to_s)))
      render 'show'
    end

  end
  private
    def next_address(address)
      return 'billing_address' if address == 'shipping_address'
      'shipping_address'
    end

    def get_current_user
      @user = current_user
    end

    def permitted_params(address_type)
      address = address_type.to_sym
      params.require(:user).permit(address => Address::ADDRESS_ATTRIBUTES)[address]
    end
end
