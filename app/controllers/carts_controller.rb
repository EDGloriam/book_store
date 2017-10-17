class CartsController < ApplicationController
  before_action :set_order
  # load_and_authorize_resource
  def show
    @order_items = get_order_items
  end

  def update
    @order.update(subtotal: @order.subtotal)
    coupon = Coupon.find_by(code: cart_params[:coupon])

    if (coupon.present? && coupon.used)
      flash[:danger] = "This coupon has been already used"
    elsif @order.discount_applied
      flash[:danger] = "You can apply one coupon only"
    elsif coupon.present?
      @order.apply_coupon(coupon.apply)
    end

    @order.update(total: @order.total)
    redirect_to cart_path
  end

  private

    def cart_params
      params.require(:cart).permit(:coupon)
    end

    def get_order_items
      puts "################################### carts_controller.GET OrderItems ###########################################"
      return @order.order_items if cookies[:order_id].present?
      current_user.orders.in_progress[0].order_items

      # return current_user.orders.in_progress[0] if current_user
      # @order.order_items if cookies[:order_id].present?
    end
end
