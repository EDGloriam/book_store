class BooksController < ApplicationController
  def index   # GET /books
    @batch_of_books = []
    Book.find_each(batch_size: 8) do |book|
      @batch_of_books << book
    end
  end

  def show    # GET /books/:id
    @book = Book.find_by(id: params[:id])
    puts @book
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
