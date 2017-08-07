class PagesController < ApplicationController
  def index
    @books = Book.all
    @newest_books = Book.order(:created_at).reverse_order.limit(3)
  end
end
