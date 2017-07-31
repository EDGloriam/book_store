class PagesController < ApplicationController
  def index
    @books = Book.all
  end
end
