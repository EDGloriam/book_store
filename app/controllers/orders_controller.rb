class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_order

  def index
    @orders =
      if params[:status].present?
        current_user.orders.status(params[:status])
      else
        current_user.orders.where.not(order_status: nil).where.not(order_status: :in_progress)
      end
  end

  def show
    @order = Order.find_by(id: params[:id])
  end
end
