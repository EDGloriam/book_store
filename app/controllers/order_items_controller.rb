class OrderItemsController < ApplicationController
  before_action :retrieve_order
  after_action :save

  def create
    if book_already_chosen?(order_item_params[:book_id])
      increment_quantity
    else
      @order_item = @order.order_items.create(order_item_params)
    end
    redirect_back(fallback_location: books_path)
  end

  # def update
  #   @order_item = @order.order_items
  #   @order_item.update_attributes(order_item_params)
  #   @order_items = @order.order_items
  # end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_path
  end

private

  def book_already_chosen?(id)
    @existing_order = @order.order_items.where(book_id: id)
    @existing_order.count >= 1
  end

  def  increment_quantity
    @existing_order.last.update_column(:quantity, @existing_order.last.quantity + order_item_params[:quantity].to_i)
  end

  def save
    @order.save
  end

  def retrieve_order
    @order = current_order
  end

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
