class PagesController < ApplicationController
  def index
    unless current_user
      cookies[:book_id] = [{id:1, count: 1}, {id:2, count: 3}]
    end
    @books = Book.take(4)
    @newest_books = Book.order(:created_at).reverse_order.limit(3)
  end
end
