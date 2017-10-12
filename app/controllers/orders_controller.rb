class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order

  def index
    @orders = current_user.orders.where.not(order_status: nil).where.not(total: 0)
  end
end
