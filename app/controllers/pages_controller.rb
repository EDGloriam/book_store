class PagesController < ApplicationController
  def index
    @books = Book.take(4)
    @newest_books = Book.order(:created_at).reverse_order.limit(3)
    @order_item = current_order.order_items.new
  end
end
