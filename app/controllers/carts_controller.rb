class CartsController < ApplicationController
  # include CurrentOrder
  before_action :set_order

  def show
    @order_items = get_order_items
  end

  def update
    @order.update_column( :subtotal, @order.subtotal)
    coupon = Coupon.find_by( code: cart_params[:coupon] )
    @order.update_column( :total, subtotal - subtotal * coupon.try_to_use_) if coupon
  end

  private

    def cart_params
      params.require(:cart).permit(:coupon)
    end

    def get_order_items
      return @order.order_items if cookies[:order_id].present?
      current_user.order.in_progress
    end
end
