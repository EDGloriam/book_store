class CartsController < ApplicationController
  include CurrentOrder
  before_action :set_order

  def show
    @order_items = get_order_items
  end

  private

    def get_order_items
      return @order.order_items if cookies[:order].blank?
      JSON.parse( cookies[:order] )
    end
end
