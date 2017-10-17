class CartsController < ApplicationController
  before_action :set_order

  def show
    @order.valid? #needs when coupon has added and order items are changing
    @order_items = get_order_items
  end

  def update
    # @order.update_subtotal
    coupon = Coupon.find_by(code: cart_params[:coupon])
    if coupon.present?
      if coupon.used
        flash[:danger] = "This coupon has been already used"
      elsif @order.discount_applied
        flash[:danger] = "You can apply one coupon only"
      else
        @order.apply_coupon(coupon.applied)
      end
    end

    @order.update_total
    redirect_to cart_path
  end

  private

    def cart_params
      params.require(:cart).permit(:coupon)
    end

    def get_order_items
      return @order.order_items if cookies[:order_id].present?
      current_user.orders.in_progress[0].order_items
    end
end
