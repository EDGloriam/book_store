class OrdersController < ApplicationController
  before_action :authenticate_user!


  def index
    @orders = current_user.orders.where.not(order_status: nil)
  end
end
