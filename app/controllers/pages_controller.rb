class PagesController < ApplicationController
  def index
    @books = Book.filter('popular_first').limit(4)
    @newest_books = Book.order(:created_at).reverse_order.limit(3)
  end
end
