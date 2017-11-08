class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    params_page = permited_params[:page] || 1
    limit_books = params_page.to_i * 12

    session[:category_id] = permited_params[:category] if permited_params[:category].present?
    session[:filter] = permited_params[:filter] if permited_params[:filter].present?
    session.delete(:category_id) if permited_params[:category].nil? || permited_params[:category].empty?
    @books = Book.category(session[:category_id]).filter(session[:filter]).page(params_page).per(limit_books)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.where(book_id: params[:id], verified: true).order(created_at: :desc)
    @review = Review.new
  end

  private
    def permited_params
      params.permit(:category, :page, :filter)
    end
end
