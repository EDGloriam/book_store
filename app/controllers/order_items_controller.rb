class OrderItemsController < ApplicationController
  respond_to :html, :json
  before_action :set_order, only: [:create, :destroy]

  def create
    @order_item = @order.add_book(order_item_params)
    flash_msg(@order_item.save)
    @order.valid?
    redirect_back(fallback_location: books_path)
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_path
  end

  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(quantity: order_item_params[:quantity])
    render json: order_item
  end

private

  def flash_msg(condition)
    return flash[:success] = 'Added to the Cart' if condition
    flash[:danger] = 'Something wrong (look OrderItemsController)'
  end


  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity, :change_quantity)
  end
end
