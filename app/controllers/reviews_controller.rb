class ReviewsController < ApplicationController

  def create
    # debugger
    review = Review.new(permitted_params)
    if review.save
      flash[:success] = "Thanks for Review. It will be published as soon as Admin will approve it"
    else
      flash[:danger] = "reviews-create. error. edit me"
    end
    redirect_back(fallback_location: books_path)
  end

  private

    def permitted_params
      params.require(:review).permit(:user_id, :book_id, :rate_stars, :text)
    end
end
