class BooksController < ApplicationController
  def index   # GET /posts
    @user = current_user
  end

  def show    # GET /posts/:id
    # ...
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
