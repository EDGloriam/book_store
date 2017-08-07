class BooksController < ApplicationController
  def index
    if params[:section].present?
      @batch_of_books = Book.where(nil)
      @batch_of_books = @batch_of_books.section(params[:section])
    else
      @batch_of_books = Book.all
    end
  end

  def show    # GET /books/:id
    @book = Book.find(params[:id])
  end

  def new     # GET /posts/new
    # ...
  end

  def edit    # GET /posts/:id/edit
    # ...
  end

  def create  # POST /posts/
    # ...
  end

  def update  # PATCH /posts/:id PUT /posts/:id
    # ...
  end

  def destroy # DELETE /posts/:id
    # ...
  end
end
