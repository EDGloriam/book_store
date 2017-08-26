class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    @order.save
    redirect_back(fallback_location: books_path)
  end

  # def update
  #   @order = current_order
  #   @order_item = @order.order_items
  #   @order_item.update_attributes(order_item_params)
  #   @order_items = @order.order_items
  #   @order.save
  #   redirect_to cart_path
  # end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    @order.save
    redirect_to cart_path
  end

private
  def order_item_params
    params.require(:order_item).permit(:id, :book_id, :quantity)
  end
end
