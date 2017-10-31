class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    params_page = permited_params[:page] || 1
    limit_books = params_page.to_i * 12

    if permited_params[:section].present?
      @books = Book.section(permited_params[:section]).page(params_page).per(limit_books)
    else
      @books = Book.where(nil).page(params_page).per(limit_books)
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.where(book_id: params[:id], verified: true).order(created_at: :desc)
    @review = Review.new
  end

  private
    def permited_params
      params.permit(:section, :page)
    end
end
