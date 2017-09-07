class BooksController < ApplicationController
  def index
    if params[:section].present?
      @batch_of_books = Book.where(nil)
      @batch_of_books = @batch_of_books.section(params[:section])
    else
      @batch_of_books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.where(book_id: params[:id], verified: true).order(created_at: :desc)
    @review = Review.new
    @order_item = current_order.order_items.create
  end
end
