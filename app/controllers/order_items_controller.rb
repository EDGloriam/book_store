class OrderItemsController < ApplicationController
  include CurrentOrder
  require 'json'
  before_action :set_order, only: [:create, :destroy]

  def create
    current_user ? handle_as_user : handle_as_guest
    redirect_back(fallback_location: books_path)
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_path
  end

private

  def flash_msg(condition)
    return flash[:success] = 'Added to the Cart' if condition
    flash[:danger] = 'Something wrong'
  end

  def handle_as_guest
    cookies[:order] ||= '[]'
    @new_item = [{ book_id: "#{order_item_params[:book_id]}", quantity: "#{order_item_params[:quantity]}" }]
    @items_from_cookies = JSON.parse( cookies[:order] )
    dublicate_index =  @items_from_cookies.index{ |item| item["book_id"] == @new_item[0][:book_id] }
    cookies[:order] = JSON.generate( add_book_to_order(dublicate_index) )
    flash_msg(true)
  end

  def update_cookie_at_index!(cookie, dublicate_index)
    result = cookie[dublicate_index]['quantity'].to_i
    result += @new_item[0][:quantity].to_i
    cookie[dublicate_index]['quantity'] = result
    cookie
  end

  def add_book_to_order(dublicate_index)
    return @new_item.concat(@items_from_cookies) unless dublicate_index
    update_cookie_at_index!(@items_from_cookies, dublicate_index)
  end

  def handle_as_user
    @order_item = @order.add_book(order_item_params)
    flash_msg(@order_item.save)
  end

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
