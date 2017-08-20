class ReviewsController < ApplicationController

  def create
    Review.create(permitted_params)

    redirect_back(fallback_location: books_path)
  end

  private

    def permitted_params
      params.require(:review).permit(:user_id, :book_id, :rate_stars, :text)
    end
end
